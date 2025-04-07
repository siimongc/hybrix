const express = require('express');
const axios = require('axios');
const router = express.Router();

const fastApiUrl = 'https://ase-backend-hybrix.azurewebsites.net';

// Ruta para obtener los datos en tiempo real
router.get('/statsData/:id_test', async (req, res) => {
    const { id_test } = req.params;

    try {
        // Obtener los datos desde FastAPI
        const response = await axios.get(`${fastApiUrl}/tests/${id_test}`);
        const data = response.data;

        console.log('Tipo de datos recibidos de FastAPI:', typeof data);

        if (typeof data === 'object' && Object.keys(data).length > 0) {

            const testData = data[id_test];
            if(Array.isArray(testData) && testData.length > 0){
                //obtener el ultimo elemento del array
                const lastReading = testData[testData.length - 1];

                const filterDataForStats = {
                    speed: lastReading.speed,
                    battery: lastReading.bus_voltage,
                    temperature: lastReading.oil_temp,
                    rpm: lastReading.rpm
                };

                console.log('Última lectura enviada:', filterDataForStats);
                return res.status(200).json(filterDataForStats);
            }
            else{
                console.log('No se encontraron datos para este test ID');
                return res.status(404).json({ message: 'No data found for this test ID' });
            }
        } 
        else {
            console.log('No se encontraron datos para este test ID');
            return res.status(404).json({ message: 'No data found for this test ID' });
        }
    }
    catch (error) {
        console.log('Error al obtener los datos en tiempo real:', error.message);

        if (error.response) {
            return res.status(error.response.status).json({ error: error.response.data });
        } else {
            return res.status(500).json({ error: 'Error interno del servidor' });
        }
    }
});

// Nuevo endpoint para datos adicionales

module.exports = router;
