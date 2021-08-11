import dotenv from 'dotenv';

const envFile = process.env.NODE_ENV === 'test' ? '.env' : '.env';

dotenv.config({
  path: envFile
});