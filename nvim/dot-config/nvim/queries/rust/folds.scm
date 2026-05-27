[
    (mod_item)
    (foreign_mod_item)

    (trait_item)
    (impl_item)
    (type_item)
    (union_item)
    (const_item)

    (function_item)
    (struct_item)
    (enum_item)

    (let_declaration)
    (loop_expression)
    (for_expression)
    (while_expression)
    (if_expression)
    (match_expression)
    ;(call_expression)
    (array_expression)

    (macro_definition)
    (macro_invocation)

    ; TODO: This was too aggresive, causing extra levels on most items, but it would still be useful
    ; to fold these that are inside item bodies (like when manual scoping is employed)
    ;(block)

    (use_declaration)+
    (line_comment doc: (doc_comment))+
] @fold


;((attribute_item)*
; .
; [(function_item)
;  (struct_item)
;  (enum_item)]) @fold
