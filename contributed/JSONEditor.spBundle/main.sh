#!/bin/bash
IFS=$'\t' read -ra header
IFS=$'\t' read -ra record
cat << DOC
<html>
  <head>
    <link rel="stylesheet" href="file://${SP_BUNDLE_PATH}/jsoneditor.css">
    <script src="file://${SP_BUNDLE_PATH}/jsoneditor.js"></script>
    <script>
      window.spProcessId = '${SP_PROCESS_ID}';
      window.spQueryFile = '${SP_QUERY_FILE}';
      window.record = ${record[5]};
    </script>
    <script src="file://${SP_BUNDLE_PATH}/main.js"></script>
  </head>
  <body>
    <div id="editor"></div>
  </body>
</html>
DOC