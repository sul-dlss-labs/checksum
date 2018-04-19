# Upload

Upload a file by POSTing form data to the `/files` endpoint with the file in
the `file` parameter like this:

```
curl -Ffile=@README.md localhost:3000/files
```

The file is held in the local file system adapter for ActiveStorage.
We use the `StoredFile` model to wrap the ActiveStorage blob. ActiveStorage
keeps some file metadata in the database.
