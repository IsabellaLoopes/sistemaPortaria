<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />
<tiles:insertDefinition name="login">

	<tiles:putAttribute name="body">
		<div class="block">
			<div id="div-login" class="p-3 mb-5 bg-white rounded centered">
				<h1 class="mt-3">Bem vindo ao <span class="color-primary">ACESSO SEGURO</span></h1>
				<p id="p-login">Preencha os dados do login para acessar</p>
	
				<form id="form-login" class="centered">
					<div class="input-group">
						<input class="input-field validar" type="text" id="login"> 
						<label class="input-label">Usuário</label>
						<div class="icone-form"><i class="fas fa-user icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
					<div class="input-group">
						<input class="input-field validar" type="password" id="senha"> 
						<label class="input-label">Senha</label>
						<div class="icone-form"><i class="fas fa-key icone-i"></i></div>
						<div class="input-progress"></div>
					</div>
				</form>
				
				<p class="d-none" id="p-loginErro"></p>
				<button type="button" class="btn btn-primary btn-formulario" onclick="login()">ENTRAR</button>
			</div>
		</div>
	</tiles:putAttribute>

	<tiles:putAttribute name="footer">
		<script>
			function login(){
				if($("#form-login #login").val() != '' && $("#form-login #senha").val() != ''){
					let param = {
							login: $("#form-login #login").val(),
							senha: $("#form-login #senha").val()
					}
					
					$.post("${pageContext.request.contextPath}/adm/login", param, function(retorno){
						$("#p-loginErro").addClass("d-none");
						let obj = JSON.parse(retorno);
						
						if(obj.DATA.erro == 0){
							abrirPagina("/login/entrar", true, obj.DATA, false)
						}else {
							$("#p-loginErro").text(obj.DATA.mensagem);
							$("#p-loginErro").removeClass("d-none");
						}
					});
				} else {
					$("#p-loginErro").text("Preencha os campos obrigatórios: Login e Senha");
					$("#p-loginErro").removeClass("d-none");
				}
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>