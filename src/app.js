import express, { query } from 'express'
import cors from 'cors'
import dayjs from 'dayjs'

import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';
import connection from './database.js'



const app=express()
app.use(cors())
app.use(express.json())





//Sign-up
app.post("/sign-up" ,async(req,res)=>{

    const {name,email,password} = req.body

    

    const passwordHash = bcrypt.hashSync(password,12)
    
   
    
    try{

       const emalAlreadyRegistered = await connection.query(`
            SELECT email FROM users
            WHERE email = $1
        `,[email])

        

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
   
    
    
    const {email,password} = req.body

    try{
        const searchUser =await connection.query(`
        SELECT * FROM users
        WHERE email = $1 
        `,[email]) 

       
        
        const user = searchUser.rows[0]
        
        if(user && bcrypt.compareSync(password,user.password)){
            
            const token = uuid();

            await connection.query(`
            INSERT INTO sessions ("userId",token) 
            VALUES ($1,$2)
            `,[user.id,token])


            const userData = {
                user:user.name,
                token:token
            }
            res.send(userData)
        }else{
            res.status(401).send('email e/ou senha incorretos')
        }
    }catch(e){
        console.log('Erro na autenticação')
        console.log(e)
        res.sendStatus(400)
    }
        

})


app.get("/home", async(req,res)=>{
    
   const token = req.headers["authorization"].replace("Bearer ",'')
   try{
        const result = await connection.query(`
        SELECT "userId" FROM sessions WHERE token = $1
        `,[token])

        if(result.rows.length===0){
            res.status(401).send('Essa sessão expirou')
            return
        }

        

        const userId = result.rows[0].userId
       

       const searchTransactions = await connection.query(`
       SELECT value,description,type,date
       FROM transactions
       WHERE "userId" = $1
       `,[userId])

       
       res.status(200).send(searchTransactions.rows)


   }catch(e){
       console.log('Erro ao obter transações')
       console.log(e)
       res.sendStatus(400)
   }


  
})

app.post("/entry" ,async(req,res)=>{
   
    const{value,description,transactionType} = req.body
    
    const newValue=parseInt(value*100)
    
    const token =req.headers['authorization'].replace('Bearer ','')
    
    const today = dayjs().format("YYYY/MM/DD")
     
    try{
        const result = await connection.query(`
        SELECT * FROM sessions
        WHERE token = $1
        `,[token])

        const userId = result.rows[0].userId

        
        await connection.query(`
        INSERT INTO transactions 
        (value,description,type,date,"userId")
        VALUES 
        ($1,$2,$3,$4,$5)
        `,[newValue,description,transactionType,today,userId])
        
        
        res.sendStatus(200)
    }catch(e){
        console.log('erro ao salvar operação')
        console.log(e)
        res.sendStatus(400)
    }
    
})


app.post("/logout" , async(req,res)=>{
    const {token} = req.body
    
    try{
        await connection.query(`
            DELETE FROM sessions
            WHERE token = $1
        `,[token])

        res.sendStatus(200)
    }catch(e){
        console.log('Erro ao deletar sessão')
        console.log(e)
    }


})





export default app;