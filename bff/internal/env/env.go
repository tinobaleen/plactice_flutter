package env

import (
	"os"
	"strconv"
)

func GetEnv(key string, defalutValue string) string {

	enviroment := os.Getenv(key)

	//環境変数が存在しないなら初期値を返す
	if enviroment == "" {
		return defalutValue
	}

	//返り値となる
	return enviroment
}

func ToInt(enviroment string, defaultValue int) int {

	result, err := strconv.Atoi(enviroment)
	if err != nil {
		return defaultValue
	}
	return result
}
