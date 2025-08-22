$(function() {
    listPage(1);

    $('button[role="tab"]').on('click', function() {
        searchReset();
        listPage(1);
    });

    $('.btnCategoryManage').click(function() {
        $('#faqCategoryDialogModal').modal('show');
    });

    // FAQ Category Modal 이벤트
    $('#faqCategoryDialogModal').on('click', '.btnCategoryAddOk', function() {
        const $tr = $(this).closest('tr');
        let categoryName = $tr.find('input[name=categoryName]').val().trim();
        if (!categoryName) {
            $tr.find('input[name=categoryName]').focus();
            return false;
        }
        let url = CONTEXT_PATH  + '/admin/faq/insertCategory';
        let params = { categoryName: categoryName };
        ajaxRequest(url, 'post', params, 'json', function(data) {
            $('form[name=categoryForm]')[0].reset();
            listAllCategory();
        });
    });

    let $cloneTr = null;

    $('#faqCategoryDialogModal').on('click', '.btnCategoryUpdate', function() {
        const $tr = $(this).closest('tr');
        $cloneTr = $tr.clone(true);
        $tr.find('input').prop('disabled', false);
        $tr.find('select').prop('disabled', false);
        $tr.find('input[name=categoryName]').focus();
        $tr.find('.category-modify-btn').hide();
        $tr.find('.category-modify-btnOk').show();
    });

    $('#faqCategoryDialogModal').on('click', '.btnCategoryUpdateOk', function() {
        const $tr = $(this).closest('tr');
        let categoryId = $tr.find('input[name=categoryId]').val();
        let categoryName = $tr.find('input[name=categoryName]').val().trim();
        if (!categoryName) {
            $tr.find('input[name=categoryName]').focus();
            return false;
        }
        let url = CONTEXT_PATH  + '/admin/faq/updateCategory';
        let params = { categoryId: categoryId, categoryName: categoryName };
        ajaxRequest(url, 'post', params, 'json', function(data) {
            if (data.state === 'false') {
                alert('카테고리 수정이 불가능합니다.');
                return false;
            }
            $cloneTr = null;
            listAllCategory();
        });
    });

    $('#faqCategoryDialogModal').on('click', '.btnCategoryUpdateCancel', function() {
        const $tr = $(this).closest('tr');
        if ($cloneTr) {
            $tr.replaceWith($cloneTr);
        }
        $cloneTr = null;
    });

    $('#faqCategoryDialogModal').on('click', '.btnCategoryDeleteOk', function() {
        if (!confirm('카테고리를 삭제하시겠습니까?')) return false;
        const $tr = $(this).closest('tr');
        let categoryId = $tr.find('input[name=categoryId]').val();
        let url = CONTEXT_PATH  + '/admin/faq/deleteCategory';
        ajaxRequest(url, 'post', { categoryId: categoryId }, 'json', function() {
            listAllCategory();
        });
    });

    const myModalEl = document.getElementById('faqCategoryDialogModal');
    if (myModalEl) {
        myModalEl.addEventListener('show.bs.modal', listAllCategory);
        myModalEl.addEventListener('hidden.bs.modal', function() {
            location.href = CONTEXT_PATH  + '/admin/faq/main';
        });
    }
});

function searchReset() {
    const f = document.searchForm;
    f.kwd.value = '';
    $('#searchValue').val('');
}

function listPage(page) {
    const $tab = $('button[role="tab"].active');
    let categoryId = $tab.attr('data-categoryId');
    let kwd = $('#searchValue').val();

    let url = CONTEXT_PATH  + '/admin/faq/list';
    let params = 'pageNo=' + page + '&categoryId=' + categoryId;
    if (kwd) params += '&schType=all&kwd=' + encodeURIComponent(kwd);

    ajaxRequest(url, 'get', params, 'text', function(data) {
        $('#nav-content').html(data);
    });
}

window.addEventListener('DOMContentLoaded', function() {
    const inputEL = document.querySelector('form[name=searchForm] input[name=kwd]');
    if (inputEL) {
        inputEL.addEventListener('keydown', function(evt) {
            if (evt.key === 'Enter') {
                evt.preventDefault();
                searchList();
            }
        });
    }
});

function searchList() {
    const f = document.searchForm;
    let kwd = f.kwd.value.trim();
    $('#searchValue').val(kwd);
    listPage(1);
}

function reloadFaq() {
    searchReset();
    listPage(1);
}

function writeForm() {
    $('#myDialogModalLabel').text('자주하는 질문 등록');
    let url = CONTEXT_PATH  + '/admin/faq/write';
    ajaxRequest(url, 'get', null, 'text', function(data) {
        $('#myDialogModal .modal-body').html(data);
        $('#myDialogModal').modal("show");
    });
}

function sendOk(mode, page) {
    const f = document.faqForm;

    if (!f.categoryId.value) { alert('카테고리를 선택하세요.'); f.categoryId.focus(); return; }
    if (!f.subject.value.trim()) { alert('제목을 입력하세요.'); f.subject.focus(); return; }
    if (!f.content.value.trim()) { alert('내용을 입력하세요.'); f.content.focus(); return; }

    let url = CONTEXT_PATH  + '/admin/faq/' + mode;
    let params = $('form[name=faqForm]').serialize();

    ajaxRequest(url, 'post', params, 'json', function() {
        $('#myDialogModal .modal-body').empty();
        $('#myDialogModal').modal("hide");
        if (mode === 'write') searchReset(), listPage(1);
        else listPage(page);
    });
}

function sendCancel() {
    $('#myDialogModal .modal-body').empty();
    $('#myDialogModal').modal("hide");
}

function updateFaq(faqId, page) {
    $('#myDialogModalLabel').text('자주하는 질문 수정');
    let url = CONTEXT_PATH  + '/admin/faq/update';
    let params = 'faqId=' + faqId + '&pageNo=' + page;
    ajaxRequest(url, 'get', params, 'text', function(data) {
        $('#myDialogModal .modal-body').html(data);
        $('#myDialogModal').modal("show");
    });
}

function deleteFaq(faqId, page) {
    if (!confirm('위 게시글을 삭제 하시 겠습니까?')) return;
    let url = CONTEXT_PATH  + '/admin/faq/delete';
    let params = 'faqId=' + faqId;
    ajaxRequest(url, 'post', params, 'json', function() {
        listPage(page);
    });
}

function listAllCategory() {
    let url = CONTEXT_PATH  + '/admin/faq/listAllCategory';
    ajaxRequest(url, 'get', null, 'text', function(data) {
        $('.category-list').html(data);
    });
}
