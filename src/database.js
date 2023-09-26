import pg from 'pg'

const{Pool} = pg

const connection = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    port: Number(process.env.DB_PORT),
    database: process.env.DB_DATABASE,
 ...(process.env.NODE_ENV === 'development' ? {}:     {ssl: {         // rejectUnauthorized: process.env.NODE_ENV 
 rejectUnauthorized:true
    }} )
//     ssl: {
//         // rejectUnauthorized: process.env.NODE_ENV = "development" ? false : true 
// rejectUnauthorized:true
//     }

})

export default connection