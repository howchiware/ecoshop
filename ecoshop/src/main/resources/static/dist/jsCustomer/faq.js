$(function() {
        loadContent('faq', 0);

        $('.sidebar-nav a').on('click', function(e) {
            e.preventDefault();
            $('.sidebar-nav a').removeClass('active');
            $(this).addClass('active');
            const view = $(this).data('view');
            const category = $(this).data('category');
            loadContent(view, category);
        });
    });

    function loadContent(view, category) {
        let url = "";
        let params =  {};

        if (view === 'faq') {
            url = CONTEXT_PATH + "/customer/faqList";
            params.categoryId = category;
        } else if (view === 'inquiry') {
            url = CONTEXT_PATH + "/customer/inquiry";
        } else {
            return;
        }

        $.ajax({
            url : url,
            type : 'GET',
            data : params,
            success : function(data) {
                $('#customer-center-content').html(data);
            },
			beforeSend: function(xhr) {
				xhr.setRequestHeader('AJAX', true);
			},           
            error : function(jqXHR) {
                if(jqXHR.status === 401) {
                	alert("로그인이 필요한 서비스입니다.");
                    location.href = CONTEXT_PATH + "/member/login";
                } else {
                    $('#customer-center-content').html('<p>콘텐츠를 불러오는 중 오류가 발생했습니다.</p>');
                }
            }
        });
    }

    $(document).on('submit', 'form[name="inquiryForm"]', function(e) {
        e.preventDefault();
        const formData = $(this).serialize();
        $.ajax({
            url: CONTEXT_PATH + '/customer/inquiry',
            type: 'POST',
            data: formData,
            success: function(response) {
                if(response.state === 'true') {
                    alert('문의가 등록되었습니다.');
                    loadContent('inquiry'); 
                } else if(response.state === 'loginRequired') {
                    location.href = CONTEXT_PATH + "/member/login";
                } else {
                    alert('문의 등록에 실패했습니다.');
                }
            },
            error: function() {
                alert('문의 등록 중 오류가 발생했습니다.');
            }
        });
    });

    function detailInquiry(inquiryId, page) {
        let url = CONTEXT_PATH + '/customer/inquiry/detail';
        url += '?inquiryId=' + inquiryId + '&pageNo=' + page;
        
        $.get(url, function(data) {
            $('#customer-center-content').html(data);
        }).fail(function() {
            alert("상세 정보를 불러오는 데 실패했습니다.");
        });
    }

    $(document).on('click', '.btn-edit', function() {
        $('#inquiry-view-mode').hide();
        $('#inquiry-edit-mode').show();
    });

    $(document).on('click', '.btn-cancel-edit', function() {
        $('#inquiry-edit-mode').hide();
        $('#inquiry-view-mode').show();
    });

    $(document).on('submit', 'form[name="inquiryUpdateForm"]', function(e) {
        e.preventDefault();
        if (!confirm('문의 내용을 수정하시겠습니까?')) return;

        const formData = $(this).serialize();
        $.ajax({
            url: CONTEXT_PATH + '/customer/inquiry/update',
            type: 'POST',
            data: formData,
            success: function(response) {
                if (response.state === 'true') {
                    alert('수정되었습니다.');
                    loadContent('inquiry');
                } else {
                    alert('수정에 실패했습니다.');
                }
            }
        });
    });

    $(document).on('click', '.btn-delete', function() {
        if (!confirm('이 문의를 정말 삭제하시겠습니까?')) return;

        const inquiryId = $(this).data('inquiry-id');
        $.ajax({
            url: CONTEXT_PATH + '/customer/inquiry/delete',
            type: 'POST',
            data: { inquiryId: inquiryId },
            success: function(response) {
                if (response.state === 'true') {
                    alert('삭제되었습니다.');
                    loadContent('inquiry');
                } else {
                    alert('삭제에 실패했습니다.');
                }
            }
        });
    });