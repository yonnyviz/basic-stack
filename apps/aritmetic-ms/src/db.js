const pgp = require('pg-promise')(/* options */)
const database = process.env['DATABASE_NAME'];
const host = process.env['DATABASE_HOST'];
const port = process.env['DATABASE_PORT'];
const username = process.env['DATABASE_USERNAME'];
const password = process.env['DATABASE_PASSWORD'];
const db = pgp('postgres://' + username + ':' + password + '@' + host + ':' + port + '/' + database)

module.exports.postData = async function (numero1, numero2, resultado) {
    await db.none('INSERT INTO suma(numero1, numero2, resultado) VALUES($1, $2, $3)', [numero1, numero2, resultado])
}
