<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />
<tiles:insertDefinition name="login">

	<tiles:putAttribute name="body">
		<input type="hidden" value="0" id="idUsuario" />
		<div class="block" style="margin-top: 2% !important">
			<div id="div-login" class="p-3 mb-5 bg-white rounded centered">
				<h1 class="mt-3">ESQUECI MINHA SENHA</h1>
				<p id="p-login">Preencha os dados para recuperar sua senha</p>
	
				<form id="form-dados" class="centered">
					<div class="input-group">
						<input class="input-field validar" type="text" id="usuario"> 
						<label class="input-label">Usuário</label>
						<div class="icone-form"><i class="fas fa-user icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
					<div class="input-group">
						<input class="input-field validar" type="text" id="email"> 
						<label class="input-label">Email</label>
						<div class="icone-form"><i class="fas fa-envelope icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
					<div class="input-group">
						<input class="input-field validar" type="text" id="cpf"> 
						<label class="input-label">CPF</label>
						<div class="icone-form"><i class="fas fa-book icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
				</form>
				
				<form id="form-novaSenha" class="centered d-none">
					<div class="input-group">
						<input class="input-field validar" type="password" id="senha"> 
						<label class="input-label">Senha</label>
						<div class="icone-form"><i class="fas fa-key icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
					<div class="input-group">
						<input class="input-field validar" type="password" id="confirmarSenha"> 
						<label class="input-label">Confirmar Senha</label>
						<div class="icone-form"><i class="fas fa-key icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
				</form>
				
				<p class="d-none" id="p-loginErro" style="margin-bottom: 0% !important"></p>
				<p class="d-none" id="p-loginSucesso" style="margin-bottom: 0% !important"></p>
				<button id="btnValidar" type="button" class="btn btn-primary btn-formulario" onclick="validarUsuario()">CONTINUAR</button>
				<button id="btnSalvar" type="button" class="btn btn-primary btn-formulario d-none" onclick="salvarNovaSenha()">RESETAR</button>
				
				<p id="p-login" class="voltar d-none" style="margin-top: 2% !important; text-decoration: underline; cursor: pointer" onclick="javaScript: sair()">Fazer Login</p>
			
			</div>
		</div>
	</tiles:putAttribute>

	<tiles:putAttribute name="footer">
		<script>
			$(document).ready(function(){
				$("#form-dados #cpf").mask("999.999.999-99");
			});

			function validarUsuario(){
				if($("#form-dados #usuario").val() != '' && $("#form-dados #email").val() != '' && $("#form-dados #cpf").val() != ''){
					let param = {
							usuario: $("#form-dados #usuario").val(),
							email: $("#form-dados #email").val(),
							cpf: $("#form-dados #cpf").val()
					}
					
					$.post("${pageContext.request.contextPath}/esqueciSenha/validarUsuario", param, function(retorno){
						$("#p-loginErro").addClass("d-none");
						let obj = JSON.parse(retorno);
						console.log(obj)
						if(!$.isEmptyObject(obj.DATA)){
							$("#form-novaSenha").removeClass("d-none");
							$("#btnSalvar").removeClass("d-none");
							$("#btnValidar").addClass("d-none");
							$("#form-dados").addClass("d-none");
							
							$("#idUsuario").val(obj.DATA.usr_id)
						}else {
							$("#p-loginErro").text("Não foi possível encontrar o usuário!");
							$("#p-loginErro").removeClass("d-none");
						}
					});
				} else {
					$("#p-loginErro").text("Preencha os campos obrigatórios: Usuário, Email e Senha");
					$("#p-loginErro").removeClass("d-none");
				}
			}
			
			function salvarNovaSenha(){
				if($("#form-novaSenha #senha").val() != '' && $("#form-novaSenha #confirmarSenha").val() != '' && $("#form-novaSenha #senha").val() == $("#form-novaSenha #confirmarSenha").val()){
					let param = {
							senha: $("#form-novaSenha #senha").val(),
							id: $("#idUsuario").val()
					}
					
					$.post("${pageContext.request.contextPath}/esqueciSenha/salvarNovaSenha", param, function(retorno){
						$("#p-loginErro").addClass("d-none");
						$("#p-loginErro").addClass("d-none");
						let obj = JSON.parse(retorno);
						if(obj.DATA.erro == -1){
							$("#p-loginErro").text(obj.DATA.mensagem);
							$("#p-loginErro").removeClass("d-none");
						} else{
							$("#form-novaSenha").addClass("d-none");
							$("#btnSalvar").addClass("d-none");
							$("#p-loginSucesso").text(obj.DATA.mensagem);
							$("#p-loginSucesso").removeClass("d-none");
							$("#p-login").addClass("d-none")
							$(".voltar").removeClass("d-none")
						}
					});
				} else {
					$("#p-loginErro").text("As senhas não coincidem!");
					$("#p-loginErro").removeClass("d-none");
				}
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>