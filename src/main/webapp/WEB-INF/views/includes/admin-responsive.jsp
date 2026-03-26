<style>
/* Vô hiệu hóa tương tác với logo video trên mobile và desktop */
.sidebar h4 video{pointer-events:none;user-select:none;-webkit-user-select:none;-webkit-touch-callout:none}
</style>
<script>
(function(){
  try{
    var vids = document.querySelectorAll('video[src*="logofastfood.mp4"]');
    vids.forEach(function(v){
      try{
        v.setAttribute('playsinline','');
        v.setAttribute('disablepictureinpicture','');
        v.setAttribute('controlslist','nofullscreen noplaybackrate nodownload noremoteplayback');
        v.controls = false; v.muted = true; v.loop = true; v.autoplay = true;
        v.tabIndex = -1; v.style.pointerEvents = 'none';
        v.addEventListener('click', function(e){ e.preventDefault(); }, {passive:false});
        v.addEventListener('touchstart', function(e){ e.preventDefault(); }, {passive:false});
      }catch(e){}
    });
  }catch(e){}
})();
</script>
