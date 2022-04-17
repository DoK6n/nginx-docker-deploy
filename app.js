const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

const containerName = process.env.CONTAINER_NAME || 'default'
app.get('/', (req, res) => {
  res.send(`<h1>${containerName} Container!!!</h1/>`);
  console.log('무중단 배포!');
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
