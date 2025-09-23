from langchain_ollama import ChatOllama



def GetOllama(modelName:str ="gpt-oss:20b")->ChatOllama:
    return ChatOllama(
        model=modelName,
        temperature=0
    )