const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello, world! – Deployed via Jenkins + Terraform + Ansible');
});

const PORT = 80;
app.listen(PORT, () => console.log(`App running on port ${PORT}`));
