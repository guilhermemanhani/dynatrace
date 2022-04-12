> # Documentaçao
a documentação da aplicação nao é clara existem algumas dificuldades em entender como implementar e o que é recolhido de informação. 

> # Aplicação
> ## Web
É necessario adicionar uma chamada ao serviço para q seja enviado informação para o dynatrace. isso pode ser dificultado pela arquitetura se a classe nao for centralizada...
Obs: Testando agora novamente ele esta capturando as requisiçoes web e foi retirado o metodo de DynatraceRootAction
> ## action
Do mesmo modo da requisição web funcoes de botoes é necessario chamar uma classe no botao e passar parametro ao quais pode ser o nome do botao isso tambem fica dificultado pela arquitetura o ideial e centralizar nos botoes e nao deixar os devs comuns criarem botoes do zero o q se tornaria uma dependecia do designer sistem.
> ## navegação 
A navegação é pega automaticamente apenas sendo necessario adicionar um 
navigatorObservers: [
        DynatraceNavigationObserver(),
],

no material app e ele mostra a navegaçao via rota /home,  /details.

> ## erros 
os erros nao sao muito claros quando ocorrem apenas mostra o tipo de erro, erro de nullo ou crash.
10:29:34
Error
_CastError: Null check operator used on a null value

