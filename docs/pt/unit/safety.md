## Segurança

O firmware do controlador — Klipper ou Standalone — oferece proteção por software:

- monitoramento de temperatura com termistores;
- verificação de conexão de sensores de temperatura;
- proteção contra valores de temperatura fora dos limites de segurança;
- uso de temporizadores em caso de falha do sistema;
- desligamento automático em caso de erros de sensor ou controlador.

Além disso, a proteção de hardware é implementada:

Um protetor térmico KSD9700 (130 °C) é instalado, que corta fisicamente a alimentação do elemento aquecedor em caso de superaquecimento. Isso é crítico em caso de qualquer falha de software ou hardware.

O controlador está equipado com um fusível de 2 A que protege o dispositivo. Em caso de falha, ele se queima e desliga completamente o sistema.

Um elemento aquecedor PTC com isolamento elétrico completo é usado. Ao contrário da maioria das soluções de aquecimento, o invólucro do aquecedor PTC não está sob tensão, eliminando o risco de choque elétrico durante a instalação e manutenção da câmara da impressora 3D.

Um sistema de proteção de vários níveis como este torna o iDryer Unit uma solução segura para secagem de filamento, inclusive durante operação contínua prolongada.

!!! warning "Instalação do termistor"
    Certifique-se de que as seções de fio desnudas na base do termistor não toquem no invólucro metálico do aquecedor. Se necessário, isole essas áreas com fita Kapton ou coloque-as em tubo Teflon / tubo de encolhimento térmico.

    Lembre-se de que a temperatura do aquecedor pode atingir 140 °C.

!!! danger "KSD9700 — não é proteção final"
    KSD9700 (protetor térmico) é um dispositivo auto-recuperável: em caso de superaquecimento, abre o circuito, mas assim que a temperatura cai abaixo do limite, fecha automaticamente. Em caso de falha do aquecedor, o dispositivo será ciclicamente superaquecido e resfriado sem intervenção. Isto não é um desligamento de emergência — é um loop infinito de superaquecimento.

    Para operação contínua, substitua KSD9700 por um fusível térmico descartável (por exemplo **RH130**). Ele interrompe permanentemente o circuito ao disparar — o dispositivo desliga e permanece em estado seguro até a substituição.

!!! note "Ordem recomendada"
    Use KSD9700 durante a montagem e depuração. Depois de verificar a funcionalidade, substitua-o por um fusível térmico.
