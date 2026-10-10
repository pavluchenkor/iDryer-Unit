# Montagem

Esta página descreve a montagem física do gabinete e da eletrônica do iDryer Unit.

!!! danger "Aviso! Trabalho com equipamento elétrico de alta tensão"
    Antes de começar, leia atentamente as medidas de segurança.

    O iDryer Unit contém componentes que funcionam sob tensão de rede de 110–230 V. A conexão ou operação incorreta pode resultar em choque elétrico, incêndio ou falha do dispositivo.

!!! danger "Trabalho com tensão de rede"
    Todo trabalho de conexão a 110–230 V deve ser realizado com o dispositivo desligado. Antes da primeira inicialização, certifique-se de que todas as conexões estão adequadamente isoladas. Para mais detalhes, consulte a seção [Segurança](safety.md).

!!! warning "Medidas de segurança gerais"
    - Desconecte o dispositivo antes de qualquer trabalho.
    - Não toque em partes condutoras expostas.
    - Verifique a integridade da fiação antes de ligar.
    - Não opere o dispositivo com gabinete danificado ou fios desnudos.
    - Nunca deixe o dispositivo ligado sem supervisão.
    - Certifique-se de que todas as partes de metal do gabinete estejam adequadamente aterradas.
    - Desligue imediatamente se detectar cheiro de queimado, fumaça ou superaquecimento do gabinete.
    - Evite que umidade ou condensação entrem em contato com os componentes do dispositivo.
    - Use um disjuntor ou relé de sobrecarga.
    - Todas as conexões devem ser realizadas respeitando o isolamento elétrico.
    - Se não tiver experiência com equipamentos elétricos, consulte um técnico qualificado.

!!! tip "Antes de começar"
    Primeiro, monte o sistema em uma mesa sem montá-lo no gabinete e verifique o funcionamento de todos os componentes. As instruções de preparação estão na seção «Antes da montagem».

---

## O que você precisa

- Gabinete impresso — [CAD: modelos e parâmetros de impressão](cad.md)
- Todos os componentes da lista de peças na seção «Antes da montagem»
- Placa Unit MCU programada e testada

---

## Montagem passo a passo

### Passos 1–4: Câmara principal

<div class="grid cards" markdown>
- ![1](../../img/001.jpg)
- ![2](../../img/002.jpg)
- ![3](../../img/003.jpg)
- ![4](../../img/004.jpg)
</div>

1. Instale os rolos do suporte de bobina na base do gabinete.
2. Instale o elemento aquecedor nos locais designados.
3. Fixe o elemento aquecedor com espaçadores (esquerda + direita).
4. Instale o protetor térmico KSD9700 em contato com o elemento aquecedor.

!!! warning "Protetor térmico KSD9700"
    Certifique-se de que o KSD9700 está em contato firme com o corpo do aquecedor. O contato solto reduz a confiabilidade da proteção de emergência.

### Passos 5–7: Ventilação e damper

<div class="grid cards" markdown>
- ![5](../../img/005.jpg)
- ![6](../../img/006.jpg)
- ![7](../../img/007.jpg)
</div>

5. Instale o ventilador no gabinete e fixe-o com elementos de fixação.
6. Monta a unidade damper: conecte a lâmina e o gabinete damper. O tipo de damper depende do servo usado (3,7 g ou 9 g).
7. Conecte o servo ao damper. **Não fixe o damper ao gabinete nesta fase** — Os ângulos do servo são ajustados após a programação.

### Passos 8–10: Compartimento eletrônico

<div class="grid cards" markdown>
- ![8](../../img/008.jpg)
- ![9](../../img/009.jpg)
- ![10](../../img/010.jpg)
</div>

8. Fixe a placa de controle no compartimento eletrônico.
9. Instale e conecte o conector de alimentação. Use terminais USHVI para cabos de alimentação.
10. Roteie e fixe os cabos do sensor no duto de cabo. Instale a tampa do compartimento eletrônico.

!!! warning "Instalação do termistor"
    Instale o termistor perto da borda do elemento aquecedor, aproximadamente no meio da altura das aletas do radiador.

    As seções de fio desnudas na base do termistor não devem tocar o corpo metálico do aquecedor. Se necessário, isole essas áreas com fita Kapton ou coloque-as em tubo Teflon / tubo de encolhimento térmico.

    A temperatura do aquecedor pode atingir 140 °C.

![Instalação do termistor](../../img/thermistor.jpg)

---

## Após a montagem

Antes da primeira inicialização:

- [ ] Verifique o isolamento de todas as conexões.
- [ ] Certifique-se de que os cabos não estão presos pelas tampas.
- [ ] Certifique-se de que o disjuntor térmico está em bom contato com o elemento aquecedor.
- [ ] Verifique a integridade da fiação com um multímetro.

O próximo passo é instalar o firmware na seção «Controlador».

---

!!! quote "Agradecimentos"
    Um enorme agradecimento a Igor (@dr_perry_coke) por seu excelente trabalho, bom gosto estético e as imagens de montagem iDryer Unit fornecidas.
