{-# LANGUAGE DeriveTraversable, DeriveFoldable, DeriveFunctor #-}
module Frontend.SurfaceSyntax(
  Term(..),
  FunDef(..),
  Program,
  UntypedPrefix(..),
  RunCmd(..)
) where
import Values ( Lit(..), Prefix)
import Var(Var(..))
import Types

data Term =
      TmLitR Lit
    | TmEpsR
    | TmVar Var.Var
    | TmCatL (Maybe Var.Var) (Maybe Var.Var) Term Term
    | TmCatR Term Term
    | TmInl Term
    | TmInr Term
    | TmPlusCase Term (Maybe Var.Var) Term (Maybe Var.Var) Term
    deriving (Eq,Ord,Show)

data UntypedPrefix =
      EmpP
    | LitP Lit
    | CatPA UntypedPrefix
    | CatPB UntypedPrefix UntypedPrefix
    | SumPA UntypedPrefix
    | SumPB UntypedPrefix
    deriving (Eq, Ord, Show)

data FunDef = FD String (Ctx Var.Var) Ty Term deriving (Eq,Ord,Show)

data RunCmd = RC String [(Var.Var,UntypedPrefix)]

type Program = [Either FunDef RunCmd]