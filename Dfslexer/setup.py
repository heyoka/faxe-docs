from setuptools import setup, find_packages

setup (
  name='dfslexer',
  packages=find_packages(),
  entry_points =
  """
  [pygments.lexers]
  dfslexer = dfslexer.dfslexer:DFSLexer
  """,
)