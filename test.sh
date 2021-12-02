curl -i -X POST "https://api.box.com/oauth2/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "client_id=b43p9eo7obu4agrdxzr62kyz5yl8oecl" \
    -d "client_secret=3tI6kjQ7zOP7jN07gKRhG9mry1kxyLlJ" \
    -d "grant_type=client_credentials" \
    -d "box_subject_type=enterprise"  \
    -d "box_subject_id=862304212"