require('dotenv').config({ path: __dirname + '/.env' })
const db = require('./db')
const express = require('express');
const app = express();
const port = process.env['APP_PORT'];

app.post('/sumar/:numero1/:numero2', (req, res) => {
  var numero1 = parseInt(req.params.numero1);
  var numero2 = parseInt(req.params.numero2);
  var resultado = numero1 + numero2;

  db.postData(numero1, numero2, resultado)
    .then(resp => {
      console.log({ "resultado": resultado, "mensaje": "Registro Guardado con exito" });
      res.send(JSON.stringify({ "resultado": resultado, "mensaje": "Registro Guardado con exito" })
      )
    })
    .catch(error => {
      console.log(error)
      res.status(400).send(JSON.stringify({ "error": "Actualmente estamos presenciando errores, intentar mas tarde." }));
    })
});

app.listen(port, () => console.log(`listening on http://localhost:${port}`));
