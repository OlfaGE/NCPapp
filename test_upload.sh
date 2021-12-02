curl -i -X POST "https://upload.box.com/api/2.0/files/content" \
     -H "Authorization: Bearer CjA7PfDS9CrOctLJTIrSPwxnXTaPwFq8" \
     -H "Content-Type: multipart/form-data" \
     -F attributes='{"name":"logo.PNG", "parent":{"id":0}}' \
     -F file=@./assets/logo.PNG