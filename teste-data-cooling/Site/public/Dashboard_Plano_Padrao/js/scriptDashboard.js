function listarSensores() {

    var idEmpresaVar = sessionStorage.ID;

    console.log("Id da Empresa: ", idEmpresaVar);
    

    fetch("/usuarios/listarSensores", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            idEmpresaServer: idEmpresaVar,
        })
    }).then(function (resposta) {
        console.log("ESTOU NO THEN DO entrar()!")

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                sessionStorage.ID_SENSOR = json.idSensor;
                sessionStorage.TIPO_SENSOR = json.tipo;
                sessionStorage.STATUS_SENSOR = json.statusSensor;
                sessionStorage.NOME_SETOR = json.nomeSetor;


                json.forEach(sensor => {
                    select_sensor.innerHTML += `<option value="${sensor.idSensor}"> Sensor ${sensor.idSensor} </option>`
                })

                
                // setTimeout(function () {
                //     window.location = "./dashboard/cards.html";
                // }, 1000); // apenas para exibir o loading

            });

        } else {

            console.log("Houve um erro ao tentar realizar o login!");

            resposta.text().then(texto => {
                console.error(texto);
                finalizarAguardar(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}

function listarDataRegistro() {

    var idEmpresaVar = sessionStorage.ID;

    console.log("Id da Empresa: ", idEmpresaVar);
    

    fetch("/usuarios/listarDataRegistro", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            idEmpresaServer: idEmpresaVar,
        })
    }).then(function (resposta) {
        console.log("ESTOU NO THEN DO listarDataRegistro()!")

        if (resposta.ok) {
            console.log(resposta);

            resposta.json().then(json => {
                console.log(json);
                console.log(JSON.stringify(json));

                sessionStorage.DATA_REGISTRO = json.dataRegistro;

                json.forEach(datas => {
                    select_data.innerHTML += `<option value="${datas.dataRegistro}"> ${datas.dataRegistro} </option>`
                })

                
                // setTimeout(function () {
                //     window.location = "./dashboard/cards.html";
                // }, 1000); // apenas para exibir o loading

            });

        } else {

            console.log("Houve um erro ao tentar realizar o login!");

            resposta.text().then(texto => {
                console.error(texto);
                finalizarAguardar(texto);
            });
        }

    }).catch(function (erro) {
        console.log(erro);
    })

    return false;
}