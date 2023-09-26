import './setup.js';
import app from './app.js'


const port = Number(process.env.PORT);

app.listen(port, () => {
console.log(process.env.NODE_ENV)
  console.log(`Server is listening on port ${port}.`);
});