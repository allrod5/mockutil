from unittest.mock import Mock, _Call


def get_calls(mock: Mock):
    return [MockCall(call) for call in mock.call_args_list]


class MockCall:
    def __init__(self, call: _Call):
        self._call = call

    def get_args(self):
        return self._call[0]
