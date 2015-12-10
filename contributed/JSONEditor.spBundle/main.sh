#!/bin/bash
IFS=$'\t' read -ra header
IFS=$'\t' read -ra record
cat << SQL > "$SP_QUERY_FILE"
SELECT data FROM document WHERE i = ${record[0]};
SQL
open "sequelpro://$SP_PROCESS_ID@passToDoc/ExecuteQuery"
while [ 1 ]
do
  [[ -e "$SP_QUERY_RESULT_STATUS_FILE" ]] && break
  sleep 0.01
done

while IFS=$'\t' read -ra line || [[ -n "$line" ]]; do
    data=$line
done < "$SP_QUERY_RESULT_FILE"

cat << DOC
<html>
  <head>
    <link rel="stylesheet" href="file://${SP_BUNDLE_PATH}/jsoneditor.css">
    <script src="file://${SP_BUNDLE_PATH}/jsoneditor.js"></script>
    <script>
      window.spProcessId = '${SP_PROCESS_ID}';
      window.spQueryFile = '${SP_QUERY_FILE}';
      window.record = ${data};
    </script>
    <script src="file://${SP_BUNDLE_PATH}/main.js"></script>
  </head>
  <body>
    <div id="editor"></div>
  </body>
</html>
DOC