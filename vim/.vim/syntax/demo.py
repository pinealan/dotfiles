import pytest
import Random

'text' "text" '''text''' """text"""

b'text' b"text" b'''text''' b"""text"""
B'text' B"text" B'''text''' B"""text"""

u'text' u"text" u'''text''' u"""text"""
U'text' U"text" U'''text''' U"""text"""

r'text' r"text" r'''text''' r"""text"""
R'text' R"text" R'''text''' R"""text"""

rb'text' rb"text" rb'''text''' rb"""text"""
RB'text' RB"text" RB'''text''' RB"""text"""

f'text'
f"text"
f'''text'''
f"""text"""

f'text {x} more text'
f"text {x:.2f} more text"
f'''text {x} more text'''
f"""text {x:.2f} more text"""

{ """text {x:.2f} more text""" }
{ f"text {x:.2f} more text" }
{ f"text {x} more text", "more text" }
{ f"text {x:.2f} more text", "123 {x:.2f}" }
{ f"""text {x} more text""" }
{ f"text {x} more text", """more text {x}""" }

rb'text' rb"text" rb'''text''' rb"""text"""

f"""
Demo{x}
"""
x: int = 1


{ 1: f"""
    Demo{x} wef
 """
}

{ 1: f"""
    Demo{x} wef """ }

{ 1: f"""Demo{x} wef"""}
{ 1: f"Demo{x} wef", 2: 3123 }
[ { "key": 'value' } ]
([ { "key": 'value' } ])
help([ { "key": 'value' } ])

x: Random = 1

f'where did {x} go'
f"where did {x} go"

{ 1: f'where did {x} go', 123: 'x', x: None, 'y': x }

class BaseDefaults(object):
    """
    A text-processing pipeline. Usually you'll load this once per process, and pass the
    instance around your application.
    """

    @classmethod
    def create_lemmatizer(cls, nlp: int = None, lookups: Haha =None):
        if lookups is None:
            lookups = cls.create_lookups(nlp=nlp)
        return Lemmatizer(lookups=lookups)

    pipe_names = ["tagger", "parser", "ner"]
    writing_system = {"direction": "ltr", "has_case": True, "has_letters": True}

def func():
    pass

@pytest.a123
def func():
    pass
