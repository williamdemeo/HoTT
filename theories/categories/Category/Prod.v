Require Import Category.Core Category.Strict.
Require Import types.Prod.

Set Implicit Arguments.
Generalizable All Variables.
Set Asymmetric Patterns.
Set Universe Polymorphism.

Local Open Scope category_scope.
Local Open Scope morphism_scope.

Section prod.
  Variable C : PreCategory.
  Variable D : PreCategory.

  Definition prod : PreCategory.
    refine (@Build_PreCategory
              (C * D)%type
              (fun s d => (morphism C (fst s) (fst d)
                           * morphism D (snd s) (snd d))%type)
              (fun x => (identity (fst x), identity (snd x)))
              (fun s d d' m2 m1 => (fst m2 o fst m1, snd m2 o snd m1))
              _
              _
              _
              _);
    abstract (
        repeat (simpl || intros [] || intro);
        try f_ap; auto with morphism
      ).
  Defined.
End prod.

Local Infix "*" := prod : category_scope.

Global Instance isstrict_category_product
       `{IsStrictCategory C, IsStrictCategory D}
: IsStrictCategory (C * D).
Proof.
  typeclasses eauto.
Qed.

Module Export CategoryProdNotations.
  Infix "*" := prod : category_scope.
End CategoryProdNotations.
