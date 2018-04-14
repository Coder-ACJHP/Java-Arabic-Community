window.onload = function () {
    var deleteDiv = document.getElementById('danger-zone');
    var deleteBtn = document.getElementById('delete-btn');
    var deleteQstn = document.getElementById('delete-qstn');
    var deleteAnswr = document.getElementById('delete-answr');
    var headerP = document.getElementById('nav-header-p');
    var logoutBtn = document.getElementById('log-out-link');
    if (deleteDiv) {
        deleteDiv.addEventListener("mouseover", function () {
            deleteDiv.style.backgroundColor = "#f6d5da";
            deleteDiv.style.borderRadius = '5px';
            deleteDiv.style.transition = '0.8s'
        })
    }
    if (deleteBtn) {
        deleteDiv.addEventListener("mouseout", function () {
            deleteDiv.style.backgroundColor = '#0000'
        })
    }
    if (deleteQstn) {
        deleteQstn.addEventListener("mouseover", function () {
            deleteQstn.style.cursor = 'pointer'
        })
    }
    if (deleteAnswr) {
        deleteAnswr.addEventListener("mouseover", function () {
            deleteAnswr.style.cursor = 'pointer'
        })
    }
    if (headerP) {
        headerP
                .addEventListener(
                        "click",
                        function () {
                            window.location.href = 'https://java-arabic-community.herokuapp.com/AllQuestions';
                            return !1
                        })
    }
}
function deleteAnswer(url) {
    swal({
        title: "Are you sure?",
        text: "Are you sure you want to delete this answer?",
        type: "warning",
        showCancelButton: !0,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "No, cancel plx!",
        closeOnConfirm: !1,
        closeOnCancel: !1
    }, function (isConfirm) {
        if (isConfirm) {
            window.location.href = url;
            return !1
        } else {
            swal("Cancelled", "Your imaginary answer is safe :)", "error");
        }
    })
}
function deleteQuestion(url) {
    swal({
        title: "Are you sure?",
        text: "Are you sure you want to delete this question?",
        type: "warning",
        showCancelButton: !0,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "No, cancel plx!",
        closeOnConfirm: !1,
        closeOnCancel: !1
    }, function (isConfirm) {
        if (isConfirm) {
            window.location.href = url;
            return !1
        } else {
            swal("Cancelled", "Your imaginary question is safe :)", "error");
        }
    })
}

function cursorWait() {
    $('html, body').css("cursor", "wait");
}

function cursorAuto() {
    $('html, body').css("cursor", "auto");
}

function upVoteAnswer(idVal, url) {
    if (idVal <= 0) {
        openModal()
    } else {
        cursorWait();
        $.ajax({
            type: 'post',
            url: url,
            success: function (data) {
                cursorAuto();
                if (data.includes('You already')) {
                    swal("Cancelled!", data, "error");
                } else {
                    $('.answer-vote-div').html(data);
                }

            },
            error: function (ex) {
                cursorAuto();
                swal("Cancelled", ex, "error");
            }
        })
    }
}
function downVoteAnswer(idVal, url) {
    if (idVal <= 0) {
        openModal()
    } else {
        cursorWait();
        $.ajax({
            type: 'post',
            url: url,
            success: function (data) {
                cursorAuto();
                if (data.includes('You already')) {
                    swal("Cancelled!", data, "error");
                } else {
                    $('.answer-vote-div').html(data);
                }
            },
            error: function (ex) {
                cursorAuto();
                swal("Cancelled", ex, "error");
            }
        })
    }
}
function upVoteQuestion(idVal, url) {
    if (idVal <= 0) {
        openModal()
    } else {
        cursorWait();
        $.ajax({
            type: 'post',
            url: url,
            success: function (data) {
                cursorAuto();
                if (data.includes('You already')) {
                    swal("Cancelled!", data, "error");
                } else {
                    $('.question-vote-div').html(data);
                }

            },
            error: function (ex) {
                cursorAuto();
                swal("Cancelled", ex, "error");
            }
        });
    }
}
function downVoteQuestion(idVal, url) {
    if (idVal <= 0) {
        openModal()
    } else {
        cursorWait();
        $.ajax({
            type: 'post',
            url: url,
            success: function (data) {
                cursorAuto();
                if (data.includes('You already')) {
                    swal("Cancelled!", data, "error");
                } else {
                    $('.question-vote-div').html(data);
                }
            },
            error: function (ex) {
                cursorAuto();
                swal("Cancelled", ex, "error");
            }
        });
    }
}