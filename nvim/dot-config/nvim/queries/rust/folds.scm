[
    (mod_item)
    (foreign_mod_item)

    (trait_item)
    (impl_item)
    (type_item)
    (union_item)
    (const_item)

    (function_item)
    (parameters)
    (struct_item)
    (enum_item)

    (let_declaration)
    (loop_expression)
    (for_expression)
    (while_expression)
    (if_expression)
    (match_expression)
    (array_expression)

    (match_arm)

    (macro_definition)
    (macro_invocation)

    (closure_expression
      body: (block))

] @fold

(use_declaration)+ @fold
(line_comment doc: (doc_comment))+ @fold
