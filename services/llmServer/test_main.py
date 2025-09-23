import asyncio
from src.server.factoryApp import FactoryAsyncServer


async def test_main():

    asyncServer = FactoryAsyncServer()

    await asyncServer.start()
    await asyncServer.wait_for_termination()
    


if __name__ == "__main__":
    print("test_main start with async")
    asyncio.run(test_main())
    print("test main done")