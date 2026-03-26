<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<button id="chatFab" class="btn btn-primary" style="position:fixed;bottom:20px;right:20px;border-radius:50%;width:56px;height:56px;z-index:1050;box-shadow:0 4px 12px rgba(0,0,0,0.2)">
    <i id="chatFabIcon" class="fas fa-comments"></i>
</button>
<div id="chatWidget" class="card" style="position:fixed;bottom:90px;right:20px;width:320px;max-height:420px;display:none;z-index:1050;box-shadow:0 8px 24px rgba(0,0,0,0.2)">
    <div class="card-header d-flex justify-content-between align-items-center">
        <span><i class="fas fa-headset me-1"></i>Hỗ trợ trực tuyến</span>
        <button class="btn btn-sm btn-outline-secondary" id="chatClose">×</button>
    </div>
    <div class="card-body" style="overflow:auto;max-height:300px" id="chatMessages"></div>
    <div class="card-footer">
        <div class="input-group">
            <input type="text" class="form-control" id="chatInput" placeholder="Nhập tin nhắn...">
            <button class="btn btn-primary" id="chatSend">Gửi</button>
        </div>
    </div>
    </div>
<style>
    #chatWidget .card-header{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);color:#fff;border:none}
    #chatWidget .btn.btn-primary{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);border:none}
    #chatWidget .form-control{border-radius:10px}
    #chatWidget .bubble-user{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);color:#fff;padding:8px 12px;border-radius:12px;box-shadow:0 2px 6px rgba(0,0,0,.08)}
    #chatWidget .bubble-support{background:#f8f9fa;border:1px solid #eee;color:#333;padding:8px 12px;border-radius:12px;box-shadow:0 2px 6px rgba(0,0,0,.08)}
    #chatFab{background:linear-gradient(135deg,#FF6B35 0%,#F7931E 100%);border:none}
    #chatFabIcon{transition:transform .2s ease}
    #chatFab.open #chatFabIcon{transform:rotate(90deg)}
</style>
<script>
(function(){
    var fab = document.getElementById('chatFab');
    var widget = document.getElementById('chatWidget');
    var closeBtn = document.getElementById('chatClose');
    var msgBox = document.getElementById('chatMessages');
    var input = document.getElementById('chatInput');
    var send = document.getElementById('chatSend');
    var fabIcon = document.getElementById('chatFabIcon');
    var poll = null;
    function render(messages){
        msgBox.innerHTML = '';
        messages.forEach(function(m){
            var align = m.sender === 'user' ? 'text-end' : 'text-start';
            var cls = m.sender === 'user' ? 'bubble-user' : 'bubble-support';
            var item = document.createElement('div');
            item.className = 'mb-2 ' + align;
            var bubble = document.createElement('div');
            bubble.className = 'd-inline-block ' + cls;
            bubble.textContent = m.content;
            var time = document.createElement('div');
            time.className = 'small text-muted mt-1';
            time.textContent = m.time;
            time.style.display = 'none';
            item.appendChild(bubble);
            item.appendChild(time);
            item.addEventListener('click', function(){ time.style.display = (time.style.display==='none'?'block':'none'); });
            msgBox.appendChild(item);
        });
        msgBox.scrollTop = msgBox.scrollHeight;
    }
    function showLoginRequired(){
        msgBox.innerHTML = '';
        var item = document.createElement('div');
        item.className = 'mb-2 text-center';
        var bubble = document.createElement('div');
        bubble.className = 'd-inline-block px-2 py-1 rounded bg-warning text-dark';
        var link = document.createElement('a');
        link.href = '${pageContext.request.contextPath}/login';
        link.className = 'ms-1';
        link.textContent = 'Đăng nhập';
        bubble.textContent = 'Bạn cần đăng nhập để chat.';
        bubble.appendChild(link);
        item.appendChild(bubble);
        msgBox.appendChild(item);
        if (poll) { clearInterval(poll); poll = null; }
        send.disabled = true;
        input.disabled = true;
        input.placeholder = 'Vui lòng đăng nhập để chat';
    }
    function fetchMessages(){
        fetch('${pageContext.request.contextPath}/chat')
            .then(function(r){ if (r.status === 401) { showLoginRequired(); return null; } if(!r.ok) throw new Error('HTTP '+r.status); return r.json(); })
            .then(function(data){ if (data) render(data); });
    }
    function sendMessage(){
        var text = (input.value||'').trim();
        if(!text) return;
        send.disabled = true;
        fetch('${pageContext.request.contextPath}/chat', {
            method: 'POST', headers: {'Content-Type':'application/x-www-form-urlencoded;charset=UTF-8'},
            body: 'message=' + encodeURIComponent(text)
        }).then(function(r){ if (r.status === 401) { showLoginRequired(); return null; } if(!r.ok) throw new Error('HTTP '+r.status); return r.json(); })
          .then(function(data){ if (data) { input.value=''; render(data); } })
          .finally(function(){ send.disabled = false; });
    }
    function openWidget(){ widget.style.display='block'; fab.classList.add('open'); fabIcon.className='fas fa-times'; fetchMessages(); if(poll) clearInterval(poll); poll=setInterval(fetchMessages,3000); }
    function closeWidget(){ widget.style.display='none'; fab.classList.remove('open'); fabIcon.className='fas fa-comments'; if(poll){ clearInterval(poll); poll=null; } }
    fab.addEventListener('click', function(){ if(widget.style.display==='none' || widget.style.display==='') { openWidget(); } else { closeWidget(); } });
    closeBtn.addEventListener('click', function(){ closeWidget(); });
    send.addEventListener('click', sendMessage);
    input.addEventListener('keydown', function(e){ if(e.key==='Enter'){ e.preventDefault(); sendMessage(); }});
})();
</script>
