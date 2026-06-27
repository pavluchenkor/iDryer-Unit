# Resolução de problemas de conexão do iDryer Unit

Durante o uso do **iDryer Unit**, podem ocorrer problemas de estabilidade de conexão (interrupções, perda de MCU, funcionamento instável).  
Na maioria dos casos, isso não se deve ao dispositivo em si, mas a fatores externos: vibrações, interferências eletromagnéticas ou características de carga.

Abaixo estão as causas principais e como resolvê-las.

---

## 1. Vibração do cabo USB

!!! warning "Sintomas"
    - Interrupções periódicas de conexão  
    - O dispositivo desaparece do sistema  
    - A conexão é restaurada ao tocar o cabo  

!!! info "Causa"
    Vibrações da impressora ou do secador podem causar micro movimentos do conector USB, resultando em perda temporária de contato.

!!! success "Solução"
    - Fixe firmemente o cabo USB no conector  
    - Evite tensão no cabo  
    - Se necessário:
        - use um cabo com ajuste mais apertado  
        - prenda o cabo com cola quente / braçadeiras / suporte  

---

## 2. Interferência de cabos de alimentação

!!! warning "Sintomas"
    - Perda de conexão ao ativar aquecimento ou ventilador  
    - Reinicializações aleatórias do dispositivo  
    - Funcionamento instável sem razão óbvia  

!!! info "Causa"
    Os cabos de alimentação CA criam interferências eletromagnéticas que se acoplam ao cabo USB.

!!! success "Solução"
    - Separe o cabo USB e os cabos de alimentação o máximo possível  
    - Não os instale no mesmo condutor de cabos  
    - Evite roteamento paralelo em longas distâncias  
    - Instale um filtro de ferrite (cilindro de ferrite) no cabo USB mais perto do controlador e/ou da placa da impressora

---

## 3. Interferência do ventilador

!!! warning "Sintomas"
    - Perda de conexão ao ligar/desligar o ventilador  
    - Falhas que coincidem com o funcionamento do ventilador do secador  
    - Instabilidade no controle PWM  

!!! info "Causa"
    Um ventilador de 110–230 V é equipado com fonte chaveada e pode gerar interferências que afetam as linhas de sinal.

!!! success "Solução"
    Recomenda-se instalar um **RC-snubber (snubber)** em paralelo com o ventilador. Ou use um filtro de ferrite no cabo USB.

---

## 4. Porta USB 3.0 – problemas durante a operação

!!! warning "Sintomas"
    - Interrupções periódicas de conexão durante a operação  
    - O dispositivo desaparece do sistema sem motivo aparente  
    - O problema desaparece ao mudar para outra porta  

!!! info "Causa"
    Este é um problema comum com dispositivos USB funcionando em modo Full Speed (USB 2.0) conectados a portas USB 3.0. Os computadores modernos usam repetidores eUSB2 em portas USB 3.0, que não são completamente compatíveis com a especificação USB 2.0 – isso causa erros de sincronização e enumeração. O problema foi oficialmente confirmado pela STMicroelectronics: [FAQ no site ST](https://community.st.com/t5/stm32-mcus/faq-possible-communication-failure-between-stlink-v3-and-some/ta-p/736578).

!!! success "Solução"
    - Conecte iDryer Unit **apenas em portas USB 2.0** (normalmente conectores pretos)  
    - Se todas as portas forem USB 3.0 – use um **hub USB ativo com portas USB 2.0**

---

## 5. Porta USB 3.0 – problemas durante a programação

!!! warning "Sintomas"
    - Controlador não é reconhecido no modo bootloader (BOOTSEL)  
    - Programação do firmware falha ou trava  
    - Dispositivo é reconhecido, mas escrita de imagem falha  

!!! info "Causa"
    Mesmo problema de compatibilidade USB 3.0 / xHCI. Particularmente relevante ao programar via portas USB Type-C em notebooks modernos – eles usam repetidores eUSB2 problemáticos com mais frequência.

!!! success "Solução"
    - Durante a programação, conecte o controlador **apenas a uma porta USB 2.0**  
    - Prefira portas USB Type-A na parte traseira do PC  
    - Se o problema persistir – use um **hub USB ativo com portas USB 2.0**
