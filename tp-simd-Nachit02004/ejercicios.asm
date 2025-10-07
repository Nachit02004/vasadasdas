; Hace que los accesos a memoria por defecto se compilen como [rip + offset]
; en lugar de [offset_desde_el_0x0].
;
; Ver https://www.nasm.us/doc/nasmdoc7.html#section-7.2.1 para más información
DEFAULT REL

; El valor a poner en los campos `<ejercicio>_hecho` una vez estén completados
TRUE  EQU 1
; El valor a dejar en los campos `<ejercicio>_hecho` hasta que estén completados
FALSE EQU 0

; Offsets a utilizar durante la resolución del ejercicio.
PARTICLES_COUNT_OFFSET    EQU 56
PARTICLES_CAPACITY_OFFSET EQU 64
PARTICLES_POS_OFFSET      EQU 72
PARTICLES_COLOR_OFFSET    EQU 80
PARTICLES_SIZE_OFFSET     EQU 88
PARTICLES_VEL_OFFSET      EQU 96

section .rodata

; La descripción de lo hecho y lo por completar de la implementación en C del
; TP.
global ej_asm
ej_asm:
  .posiciones_hecho: db FALSE
  .tamanios_hecho:   db FALSE
  .colores_hecho:    db FALSE
  .orbitar_hecho:    db FALSE
  ALIGN 8
  .posiciones: dq ej_posiciones_asm
  .tamanios:   dq ej_tamanios_asm
  .colores:    dq ej_colores_asm
  .orbitar:    dq ej_orbitar_asm

; Máscaras y valores que puede ser útil cargar en registros vectoriales.
;
; ¡Agregá otras que veas necesarias!
ALIGN 16
ceros:      dd  0.0,    0.0,     0.0,    0.0
unos:       dd  1.0,    1.0,     1.0,    1.0

section .text

; Actualiza las posiciones de las partículas de acuerdo a la fuerza de
; gravedad y la velocidad de cada una.
;
; Una partícula con posición `p` y velocidad `v` que se encuentra sujeta a
; una fuerza de gravedad `g` observa lo siguiente:
; ```
; p := (p.x + v.x, p.y + v.y)
; v := (v.x + g.x, v.y + g.y)
; ```
;
; void ej_posiciones(emitter_t* emitter, vec2_t* gravedad);
ej_posiciones_asm:
	mov rcx, [rdi + PARTICLES_COUNT_OFFSET] ; rcx : count
	mov rdx, [rdi + PARTICLES_POS_OFFSET]	; rdx : positions
	mov r8,  [rdi + PARTICLES_VEL_OFFSET]	; r8: velocities

	xor r9, r9								;r9:i
	jmp .check

	.loop:
        ; Cuerpo del loop
		add r9, 0 ; ¿Cantidad de partículas por loop?
	.check:
		cmp r9, rcx			; while i < count
		jb .loop
	ret

; Actualiza los tamaños de las partículas de acuerdo a la configuración dada.
;
; Una partícula con tamaño `s` y una configuración `(a, b, c)` observa lo
; siguiente:
; ```
; si c <= s:
;   s := s * a - b
; sino:
;   s := s - b
; ```
;
; void ej_tamanios(emitter_t* emitter, float a, float b, float c);
ej_tamanios_asm:
	ret

; Actualiza los colores de las partículas de acuerdo al delta de color
; proporcionado.
;
; Una partícula con color `(R, G, B, A)` ante un delta `(dR, dG, dB, dA)`
; observa el siguiente cambio:
; ```
; R = R - dR
; G = G - dG
; B = B - dB
; A = A - dA
; si R < 0:
;   R = 0
; si G < 0:
;   G = 0
; si B < 0:
;   B = 0
; si A < 0:
;   A = 0
; ```
;
; void ej_colores(emitter_t* emitter, SDL_Color a_restar);
ej_colores_asm:
	ret

; Calcula un campo de fuerza y lo aplica a cada una de las partículas,
; haciendo que tracen órbitas.
;
; La implementación ya está dada y se tiene en el enunciado una versión más
; "matemática" en caso de que sea de ayuda.
;
; El ejercicio es implementar una versión del código de ejemplo que utilice
; SIMD en lugar de operaciones escalares.
;
; void ej_orbitar(emitter_t* emitter, vec2_t* start, vec2_t* end, float r);
ej_orbitar_asm:
	ret
