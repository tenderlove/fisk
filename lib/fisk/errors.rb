class Fisk
  module Errors
    class Error < StandardError
    end

    # Raised when a temporary register is released more than once
    class AlreadyReleasedError < Error
    end

    # Raised when a temporary register is used after it has been released
    class UseAfterInvalidationError < Error
    end

    # Raised when a temporary register hasn't been released, but local register
    # allocation was requested
    class UnreleasedRegisterError < Error
    end

    # Raised when a temporary register hasn't been assigned a real register,
    # but it's used in the encoding process.
    class UnassignedRegister < Error
    end

    # Raised when a label is used but the location is never defined.  For
    # example, the `label` method is called, but there is no corresponding
    # `put_label`
    class MissingLabel < Error
    end

    # Raised when a label is defined multiple times.  For example, calling
    # `put_label` with the same name twice
    class LabelAlreadyDefined < Error
    end
  end
end
