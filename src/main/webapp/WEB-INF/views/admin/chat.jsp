<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản trị Chat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .page{padding:20px}
        .session-list{flex:1;overflow:auto}
        .messages{flex:1;overflow:auto;background:#fff;border:1px solid #eee;border-radius:12px;padding:10px;box-shadow:0 4px 12px rgba(0,0,0,.06)}
        .bubble{display:inline-block;padding:8px 12px;border-radius:12px;margin:4px 0;box-shadow:0 2px 6px rgba(0,0,0,.08)}
        .bubble.user{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);color:#fff}
        .bubble.support{background:#f8f9fa;border:1px solid #eee;color:#333}
        .msg-time{display:none;font-size:.8rem;color:#6c757d;margin-top:4px}
        .msg-item.show .msg-time{display:block}
        .sidebar{min-height:100vh;background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);color:#fff;box-shadow:2px 0 10px rgba(0,0,0,.1)}
        .sidebar a{color:rgba(255,255,255,.9);padding:12px 20px;display:block;text-decoration:none;transition:all .3s ease;border-radius:8px;margin:2px 10px}
        .sidebar a:hover{color:#fff;background-color:rgba(255,255,255,.2);transform:translateX(5px)}
        .sidebar a.active{background-color:rgba(255,255,255,.3);color:#fff;font-weight:600}
        .chat-col{display:flex;flex-direction:column;height:100%}
        .session-col{display:flex;flex-direction:column;height:100%}
        .chat-header{position:sticky;top:0;background:#fff;z-index:2;padding:6px 8px;border-bottom:1px solid #eee}
        .chat-title{font-weight:600}
        .avatar-circle{width:32px;height:32px;border-radius:50%;background:#e9ecef;display:inline-block;margin-right:8px}
        .avatar-img{width:32px;height:32px;border-radius:50%;object-fit:cover;border:1px solid #eee;margin-right:8px}
        .chat-header .btn-link{padding:4px 8px}
        .input-bar{position:sticky;bottom:0;background:#fff;padding:8px;border-top:1px solid #eee}
        @media(min-width:992px){.main-content{height:100vh;overflow-y:auto;padding:30px}}
        .input-group .form-control{border-radius:10px}
        .input-group .btn-primary{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);border:none}
        .list-group-item{border:none;border-radius:10px;margin-bottom:8px}
        .list-group-item.active{background:rgba(255,255,255,.2);color:#fff}
        .session-list .list-group-item.active{background:#e9ecef;color:#333}
        @media(max-width:991.98px){.main-content{height:auto;overflow-y:visible;padding:16px}.container-fluid,.row{height:auto}.row.h-100{height:auto!important}.chat-col{min-height:100vh;display:flex;flex-direction:column}.session-col{height:auto;display:block}.messages{flex:1;padding-bottom:88px}.sidebar{position:fixed;top:0;left:0;height:100vh;width:260px;transform:translateX(-100%);transition:transform .3s ease;z-index:1040}.sidebar.active{transform:translateX(0)}.sidebar-overlay{position:fixed;inset:0;background:rgba(0,0,0,.4);z-index:1035;display:none}.sidebar-overlay.show{display:block}.input-bar{position:fixed;left:0;right:0;bottom:0;background:#fff;padding:8px;border-top:1px solid #eee;z-index:1030}}
        @media(max-width:991.98px){ .sidebar h4 video{ display:none !important; } }
    </style>
    </head>
<body>
<div class="container-fluid p-0">
    <div class="row g-0 align-items-start">
        <div class="col-md-2 p-0 sidebar">
            <div class="p-4 text-center">
                <h4>
                    <video src="${pageContext.request.contextPath}/images/logofastfood.mp4" alt="Fast Food Logo" style="height:30px;margin-right:10px;pointer-events:none" autoplay muted loop playsinline disablepictureinpicture controlslist="nofullscreen noplaybackrate nodownload noremoteplayback"></video>
                    Fast Food Admin
                </h4>
                <hr class="text-white">
                <div class="text-center">
                    <i class="fas fa-user-circle fa-2x mb-2"></i>
                    <p class="mb-0">Admin</p>
                    <small class="text-white-50"><script>document.write(new Date().toLocaleDateString('vi-VN'));</script></small>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-pie me-2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-hamburger me-2"></i> Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-tags me-2"></i> Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart me-2"></i> Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users me-2"></i> Người dùng</a>
            <a href="${pageContext.request.contextPath}/admin/voucher"><i class="fas fa-ticket-alt me-2"></i> Voucher</a>
            <a href="${pageContext.request.contextPath}/admin/statistics"><i class="fas fa-chart-bar me-2"></i> Thống kê</a>
            <a href="${pageContext.request.contextPath}/admin/chat" class="active"><i class="fas fa-comments me-2"></i> Chat</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng xuất</a>
        </div>
        <div class="col-md-10 main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center">
                    <button class="btn btn-outline-primary d-md-none me-2" id="adminMenuBtn" aria-label="Mở menu">
                        <i class="fas fa-bars"></i>
                    </button>
                    <h2 class="mb-0"><i class="fas fa-comments me-2"></i>Chat</h2>
                </div>
            </div>
            <div class="row h-100">
                <div class="col-12 col-md-4 session-col mb-3 mb-md-0 d-none d-md-block">
                    <h5 class="mb-3">Phiên chat</h5>
                    <ul class="list-group session-list" id="sessionList"></ul>
                </div>
                <div class="col-12 col-md-8 chat-col">
                    <div class="chat-header d-flex align-items-center">
                        <button class="btn btn-link d-md-none me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#sessionsOffcanvas"><i class="fas fa-chevron-left"></i></button>
                        <img id="curAvatar" class="avatar-img d-none" alt="Avatar">
                        <span id="curAvatarFallback" class="avatar-circle"></span>
                        <span class="chat-title" id="curName">Khách</span>
                    </div>
                    <div class="messages" id="msgBox"></div>
                    <div class="input-bar">
                        <div class="input-group">
                        <input type="text" class="form-control" id="adminMsg" placeholder="Nhập tin phản hồi...">
                        <button class="btn btn-primary" id="btnSend"><i class="fas fa-paper-plane"></i> Gửi</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="sidebarOverlay" class="sidebar-overlay d-md-none"></div>

<!-- Offcanvas Sessions for mobile -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="sessionsOffcanvas" aria-labelledby="sessionsLabel">
  <div class="offcanvas-header">
    <h5 id="sessionsLabel">Phiên chat</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Đóng"></button>
  </div>
  <div class="offcanvas-body p-0">
    <ul class="list-group session-list" id="sessionListMobile"></ul>
  </div>
</div>

<script>
(function(){
    var sessions=[], currentSid=null;
    var list = document.getElementById('sessionList');
    var listMobile = document.getElementById('sessionListMobile');
    var curName = document.getElementById('curName');
    var curAvatar = document.getElementById('curAvatar');
    var curAvatarFallback = document.getElementById('curAvatarFallback');
    var ctx = '${pageContext.request.contextPath}';
    if(curAvatar){ curAvatar.addEventListener('error', function(){ curAvatar.classList.add('d-none'); if(curAvatarFallback){ curAvatarFallback.classList.remove('d-none'); } }); }
    var box = document.getElementById('msgBox');
    var input = document.getElementById('adminMsg');
    var send = document.getElementById('btnSend');
    function fetchSessions(){
        fetch('${pageContext.request.contextPath}/admin/chat?action=listSessions')
          .then(function(r){ if(!r.ok) throw new Error('listSessions failed'); return r.json(); })
          .then(function(data){
              sessions = Array.isArray(data) ? data : [];
              renderSessions();
              if (!currentSid && sessions.length>0) { currentSid = sessions[0].sessionId; setTitle(sessions[0]); setAvatar(sessions[0]); fetchMessages(); }
          })
          .catch(function(){ box.innerHTML = '<div class="text-center text-muted py-3">Không tải được danh sách phiên</div>'; });
    }
    function setTitle(s){ if(curName){ curName.textContent = (s && s.name) ? s.name : 'Khách'; } }
    function normalizeSrc(src){
        if(!src) return '';
        if(/^https?:/i.test(src)) return src;
        if(src.startsWith('/')) return src;
        return ctx + '/' + src.replace(/^\/+/, '');
    }
    function setAvatar(s){
        var src = s && (s.avatarUrl || s.avatar || s.avatar_path || s.userAvatar || s.customerAvatar) || '';
        src = normalizeSrc(src);
        if(src){
            if(curAvatar){ curAvatar.src = src; curAvatar.classList.remove('d-none'); }
            if(curAvatarFallback){ curAvatarFallback.classList.add('d-none'); }
        }else{
            if(curAvatar){ curAvatar.classList.add('d-none'); }
            if(curAvatarFallback){ curAvatarFallback.classList.remove('d-none'); }
            var sid = (s && s.sessionId) ? s.sessionId : currentSid;
            if(sid){
                fetch(ctx + '/admin/chat?action=sessionInfo&sessionId=' + encodeURIComponent(sid))
                  .then(function(r){ if(!r.ok) throw 0; return r.json(); })
                  .then(function(info){ setAvatar(info); })
                  .catch(function(){});
            }
        }
    }
    function renderSessions(){
        function fill(container){
            if(!container) return;
            container.innerHTML='';
            sessions.forEach(function(s){
                var li=document.createElement('li');
                li.className='list-group-item d-flex justify-content-between align-items-center';
                li.textContent=(s.name||'Khách')+' ('+s.count+' tin, '+(s.lastTime||'')+')';
                li.style.cursor='pointer';
                li.dataset.sid = s.sessionId;
                if (currentSid && s.sessionId===currentSid) { li.classList.add('active'); }
                li.addEventListener('click', function(){
                    currentSid = li.dataset.sid;
                    Array.prototype.forEach.call(container.querySelectorAll('.list-group-item.active'), function(n){ n.classList.remove('active'); });
                    li.classList.add('active');
                    setTitle(s);
                    setAvatar(s);
                    fetchMessages();
                    if(msgPoll) clearInterval(msgPoll);
                    msgPoll=setInterval(fetchMessages, 2000);
                    var offcanvasEl = document.getElementById('sessionsOffcanvas');
                    if (offcanvasEl && offcanvasEl.classList.contains('show')) { bootstrap.Offcanvas.getInstance(offcanvasEl)?.hide(); }
                });
                container.appendChild(li);
            });
        }
        fill(list);
        fill(listMobile);
    }
    var msgPoll=null;
    function fetchMessages(){ if(!currentSid) return; box.innerHTML = '<div class="text-center text-muted py-3">Đang tải...</div>';
        fetch('${pageContext.request.contextPath}/admin/chat?action=getMessages&sessionId='+encodeURIComponent(currentSid))
          .then(function(r){ if(!r.ok) throw new Error('getMessages failed'); return r.json(); })
          .then(renderMessages)
          .catch(function(){ box.innerHTML = '<div class="alert alert-warning p-2 m-2">Không tải được tin nhắn</div>'; });
    }
    function renderMessages(msgs){
        box.innerHTML='';
        if(!Array.isArray(msgs) || msgs.length===0){ box.innerHTML = '<div class="text-center text-muted py-3">Chưa có tin nhắn</div>'; return; }
        var updatedAvatar = false;
        msgs.forEach(function(m){
            var wrap=document.createElement('div');
            var align=(m.sender==='support')?'text-end':'text-start';
            wrap.className='msg-item '+align;
            var b=document.createElement('div');
            b.className='bubble ' + (m.sender==='support'?'user':'support');
            b.textContent=m.content;
            var t=document.createElement('div');
            t.className='msg-time';
            t.textContent=m.time;
            wrap.appendChild(b);
            wrap.appendChild(t);
            wrap.addEventListener('click', function(){ wrap.classList.toggle('show'); });
            box.appendChild(wrap);
            if(!updatedAvatar){
                var asrc = m.avatarUrl || m.avatar || m.userAvatar || m.customerAvatar;
                if(asrc){ setAvatar({ avatarUrl: asrc }); updatedAvatar = true; }
            }
        }); box.scrollTop=box.scrollHeight;
    }
    function sendMsg(){ if(!currentSid) return; var text=(input.value||'').trim(); if(!text) return;
        send.disabled=true;
        fetch('${pageContext.request.contextPath}/admin/chat',{
            method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded;charset=UTF-8'},
            body:'action=send&sessionId='+encodeURIComponent(currentSid)+'&message='+encodeURIComponent(text)
        }).then(r=>r.json()).then(function(data){ input.value=''; renderMessages(data); })
          .finally(function(){ send.disabled=false; });
    }
    send.addEventListener('click', sendMsg);
    input.addEventListener('keydown', function(e){ if(e.key==='Enter'){ e.preventDefault(); sendMsg(); }});
    fetchSessions(); setInterval(fetchSessions, 5000);
})();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(function(){
    var btn=document.getElementById('adminMenuBtn');
    var sidebar=document.querySelector('.sidebar');
    var overlay=document.getElementById('sidebarOverlay');
    if(btn&&sidebar&&overlay){
        btn.addEventListener('click',function(){ sidebar.classList.add('active'); overlay.classList.add('show'); });
        overlay.addEventListener('click',function(){ sidebar.classList.remove('active'); overlay.classList.remove('show'); });
    }
})();
</script>
<jsp:include page="/WEB-INF/views/includes/admin-responsive.jsp" />
</body>
</html>
