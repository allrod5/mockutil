from unittest.mock import Mock

from mockutil.call import assert_on_call_arg


def test_assert_on_call_arg_that_is_exactly():
    # given
    class ComplexClass:
        def __init__(self, foo):
            self.foo = foo
            self.bar = "bar"
    expected_foo_value = "some_value"
    mock = Mock()
    mock(ComplexClass(expected_foo_value), "bla")

    # then
    assert get_first_call(mock).get_arg(0) == expected_foo_value
