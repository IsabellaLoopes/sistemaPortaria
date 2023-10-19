<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-permissao-usuario">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">ATRIBUIR PERMISSÃO</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-incluir-usuario')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>Menu: ${dados.PARAMETROS.descMenu}</h6>
				<br>
				<form class="formPesquisa" id="menuPermissao">
					<div class="row">
						<c:forEach items="${dados.DATA.USUARIOS}" var="us">
							<div style="float: left; width: 250px; text-align: left;">
								<c:set var="selected" value="" />
								<c:forEach items="${dados.DATA.PERMISSOES}" var="pe">							  
									<c:if test="${pe.idUsuario == us.usr_id and pe.permissao == 'S'}">
								    	<c:set var="selected" value="checked"/>
								   	</c:if> 					     
								</c:forEach>
								<input type="checkbox" name="usr_id" id="boxTipo_${us.usr_id}" value="${us.usr_id}" style="height:12px !important" ${selected}>
								${us.usr_apelido}
						  	</div>
							<input type="hidden" id="idGrupoAcesso_${qtdeGrps}" value="${ga.ga_id}">
						</c:forEach>
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarPermissoes(${dados.PARAMETROS.idMenu})">Salvar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
function salvarPermissoes(id){
	let elementos = '';
	$.each($("#menuPermissao [name='usr_id']:checked"), function(index, elem){
		elementos += elem.value + ',';
	});
	
	let param = {
			idMenu: id,
			idUser: elementos
	}
	
	$.post("${pageContext.request.contextPath}/adm/menuSalvarPermissoes", param, function(retorno){
		let obj = JSON.parse(retorno);
		
		if(obj.DATA.erro == 0){
			Swal.fire({
				  title: 'Sucesso!',
				  text: obj.DATA.mensagem,
				  icon: 'success',
				  confirmButtonText: 'Ok'
				})
		} else{
			Swal.fire({
				  title: 'Ops!',
				  text: obj.DATA.mensagem,
				  icon: 'error',
				  confirmButtonText: 'Ok'
				})
		}
	})
	
}
</script>
</body>