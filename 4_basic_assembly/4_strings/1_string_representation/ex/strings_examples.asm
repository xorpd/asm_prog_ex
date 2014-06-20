; Basic Assembly
; ==============
; 
; Strings - String representation
; -------------------------------
;
; 0.    Assemble the following file. The resulting file will be a bin file.
;
; 1.    Open the resulting bin file in a hex editor, and look at its contents.
;
; 2.    Identify the different strings that were defined in this source file
;       inside the output file.
;

str1    db  'Hello world',0
str2    db  "Hello world",0
str3    db  48h,65h,6ch,6ch,6fh,20h,77h,6fh,72h,6ch,64h,0

str4    db  'Hell'
        db  'o world',0

str5    db  'Hello',20h,'world',0


song    db  'Walking in the realms of brightness',13,10
        db  'Passing the wall of above',0dh,0ah
        db  'Down into the soul',0

lines   db  'First line',0dh,0ah,'second line',0
    
