<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-editar-aparelho">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">EDITAR APARELHO</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-editar-aparelho')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formPesquisa" id="aparelhoIncluir">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-6 col-lg-8">
							<label for="descricao"><b>Descrição:</b></label> <input id="descricao"
								class="form-control validar" type="text" value="${dados.DATA.APARELHO.apa_descricao}"/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-4">
							<label for="ip"><b>IP:</b></label> <input id="ip"
								class="form-control validar" type="text" placeholder="Ex 192.168.000.001" value="${dados.DATA.APARELHO.apa_ip}" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-5">
							<label for="tipoOperacao"><b>Tipo Operação:</b></label> <select
								id="tipoOperacao" class="form-select validar">
								<c:forEach items="${dados.DATA.LISTA}" var="t">
									<option value="${t.tip_sigla}" <c:if test="${dados.DATA.APARELHO.apa_tipoOperacao == t.tip_sigla}">SELECTED</c:if>>${t.tip_descricao}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarAparelho(${dados.DATA.APARELHO.apa_id})">Confirmar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#aparelhoIncluir #ip").mask("999.999.999.999");
});
</script>
</body>