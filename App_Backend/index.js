const express = require('express');
const app = express();
const PORT = 3000;
const createVehicles = require('./routes/createVehicles'); 
const getVehicles = require('./routes/getVehicles');
const maintenanceData = require('./routes/maintenanceData');
const statsData = require('./routes/statsData')

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.status(200).send('¡Servidor backend corriendo!');
});

app.use('/hibrix/vehicle/', createVehicles);
app.use('/hibrix/vehicle/', getVehicles);
app.use('/hibrix', maintenanceData);
app.use('/hibrix', statsData);
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
