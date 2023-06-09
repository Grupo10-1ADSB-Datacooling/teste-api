var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

router.get("/", function (req, res) {
    usuarioController.testar(req, res);
});

router.get("/listar", function (req, res) {
    usuarioController.listar(req, res);
});

router.get("/listarUsuarios/:fkAdmin", function (req, res) {
    usuarioController.listarUsuarios(req, res);
});

router.get("/buscarEmpresa/:valorToken/:nomeEmpresa", function (req, res) {
    usuarioController.buscarEmpresa(req, res);
});

router.get("/listarToken/:fkEmpresa/", function (req, res) {
    usuarioController.listarToken(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.entrar(req, res);
});

router.post("/listarSensores", function (req, res) {
    usuarioController.listarSensores(req, res);
});

router.post("/listarDataRegistro", function (req, res) {
    usuarioController.listarDataRegistro(req, res);
});

router.post("/gerarToken", function (req, res) {
    usuarioController.gerarToken(req, res);
});

router.delete("/excluirToken/:fkEmpresa", function (req, res) {
    usuarioController.excluirToken(req, res);
});

module.exports = router;