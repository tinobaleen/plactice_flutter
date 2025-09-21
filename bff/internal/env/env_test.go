package env

import (
	"os"
	"testing"
)

const (
	env_key1 = "env_key1"
	env_key2 = "env_key2"
)

func Test_env(t *testing.T) {
	os.Setenv(env_key1, "123")
	os.Setenv(env_key2, "aaa")
	defer func() {
		os.Unsetenv(env_key1)
		os.Unsetenv(env_key2)
	}()

}
