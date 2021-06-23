import express from 'express'
import cors from 'cors'
import dayjs from 'dayjs'

const app=express()
app.use(cors())
app.use(express.json())

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
    console.log('minha primeira requsição fullstack')
    res.send('Chegou aqui!')
})

app.listen(4000, ()=>{

    console.log('server dodando na 4000')
})