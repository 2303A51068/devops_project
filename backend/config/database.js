import mysql from "mysql2";
import dotenv from "dotenv";

dotenv.config();

// create the connection to database

const databaseUrl =
  process.env.DATABASE_URL || "mysql://root:root@localhost:3306/db_restuarant";

const db = mysql.createConnection(databaseUrl);

db.connect((error) => {
  if (error) throw error;
  console.log("Successfully connected to the database.");
});

export default db;
