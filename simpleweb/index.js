const express = require('express');

const app = express();

app.get('/', (req,res)=>{
    res.send('only one return , hi There Mr');
});

app.listen(8080, ()=>{
    console.log('Listening on port 8080');
});