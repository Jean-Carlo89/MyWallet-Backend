import app from '../src/app.js'
import supertest from 'supertest'
import connection from '../src/database.js'



describe("POST /sign-up", () => {
   
    it("returns status 200 when new client signup", async() => {
    
        const body ={
            email:'gugabestmentor@gmail.com',
            name:'GugaBestMentor',
            password:'ultaPraFarmar'
        }
    
        const result = await supertest(app).post("/sign-up").send(body)

        expect(result.status).toEqual(200)

        
    });

    it("returns 409 if email is already in database", async()=>{
        const body ={
            email:'gugabestmentor@gmail.com',
            name:'GugaBestMentor',
            password:'ultaPraFarmar'
        }

        const result = await supertest(app).post("/sign-up").send(body)

        expect(result.status).toEqual(409)

    })

   
    
}); 




afterAll( async ()=>{

    try{
        await connection.query(`DELETE FROM users WHERE name = 'GugaBestMentor'`)
        connection.end()
    }catch(e){
        
    }
    
})