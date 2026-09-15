const page=document.documentElement;
const openButton=document.querySelector('#open-envelope');
const closeButton=document.querySelector('#close-letter');
const letter=document.querySelector('#letter');
const traceButton=document.querySelector('#trace-button');
const route=document.querySelector('#mail-route');
const replyButton=document.querySelector('#reply-button');
const now=new Date();
document.querySelector('#postmark-date').textContent=new Intl.DateTimeFormat('en-GB',{day:'2-digit',month:'short'}).format(now).toUpperCase();
document.querySelector('#letter-date').textContent=new Intl.DateTimeFormat('en-GB',{day:'numeric',month:'long',year:'numeric'}).format(now);
document.querySelector('#year').textContent=String(now.getFullYear());
function openLetter(){page.classList.add('is-open');openButton.setAttribute('aria-expanded','true');letter.setAttribute('aria-hidden','false');window.setTimeout(()=>closeButton.focus(),300)}
function closeLetter(){page.classList.remove('is-open');openButton.setAttribute('aria-expanded','false');letter.setAttribute('aria-hidden','true');openButton.focus()}
openButton.addEventListener('click',openLetter);
closeButton.addEventListener('click',closeLetter);
traceButton.addEventListener('click',()=>{const visible=route.classList.toggle('is-visible');route.setAttribute('aria-hidden',String(!visible));traceButton.setAttribute('aria-expanded',String(visible));traceButton.textContent=visible?'Hide message route':'Trace this message'});
replyButton.addEventListener('click',()=>{
  const mailbox=[100,97,118,105,100].map(code=>String.fromCharCode(code)).join('');
  const host=[100,115,116,104,111,109,112,115,111,110,46,99,111,46,117,107].map(code=>String.fromCharCode(code)).join('');
  replyButton.href=`mailto:${mailbox}@${host}`;
});
document.addEventListener('keydown',event=>{if(event.key==='Escape'&&page.classList.contains('is-open'))closeLetter()});
