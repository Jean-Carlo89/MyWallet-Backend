import express from 'express'
import cors from 'cors'
import dayjs from 'dayjs'
import pg from 'pg'
import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';

const app=express()
app.use(cors())
app.use(express.json())

//database
const{Pool} = pg

const connection = new Pool({
    user: 'postgres',
    password: '123456',
    host: 'localhost',
    port: 5432,
    database: 'mywallet'

})

app.get("/teste" , async (req,res)=>{

   const result =  await connection.query(`
    SELECT * FROM users
    `)
   res.send(result)
})



//Sign-up
app.post("/sign-up" ,async(req,res)=>{

    const {name,email,password} = req.body

    console.log(password)

    const passwordHash = bcrypt.hashSync(password,12)
    
    console.log(passwordHash)
    
    try{

       const emalAlreadyRegistered = await connection.query(`
            SELECT email FROM users
            WHERE email = $1
        `,[email])

        console.log(emalAlreadyRegistered)

        if(emalAlreadyRegistered.rows.length){
            res.sendStatus(409)
            return 
        }
        
        await connection.query(`
        INSERT INTO users (name,email,password) 
        VALUES ($1,$2,$3)
        `,[name,email,passwordHash])
        res.sendStatus(200)
    }catch(e){
        console.log('Erro ao salvar o novo usuario')
        console.log(e)
        res.sendStatus(400)
    }

})

//sign-in

app.post("/sign-in" , async(req,res)=>{
   // console.log(req.body)
    
    
    const {email,password} = req.body

    try{
        const searchUser =await connection.query(`
        SELECT * FROM users
        WHERE email = $1 
        `,[email]) 

       //console.log(searchUser.rows)
        
        const user = searchUser.rows[0]
        
        if(user && bcrypt.compareSync(password,user.password)){
            //console.log('verificado')
            const token = uuid();

            // await connection.query(`
            // INSERT INTO sessions ("userId",token) 
            // VALUES ($1,$2)
            // `,[user.id,token])


            const userData = {
                user:user.name,
                token:token
            }
            res.send(userData)
        }else{
            res.status(400).send('email e/ou senha incorretos')
        }
    }catch(e){
        console.log('Erro na autenticação')
        console.log(e)
        res.sendStatus(400)
    }
        

})


app.get("/home", async(req,res)=>{
    const today = dayjs().format("YYYY/MM/DD")
   //console.log(dayjs().format("YYYY-MM-DD"))
   
    const obj =[
        {
        date:today,
        description:'Katon',
        price:3900,
        type:'deposit'
    },

    {
        date:today,
        description:'Suiton',
        price:1700,
        type:'withdraw'
    },

    {
        date:today,
        description:'Suiton',
        price:1459,
        type:'withdraw'
    }

]

    res.send(obj)
})

app.post("/entry" ,async(req,res)=>{
    console.log(req.body)
    //console.log('minha primeira requsição fullstack')
    res.send('Chegou aqui!')
})

app.listen(4000, ()=>{

    console.log('server dodando na 4000')
})