class JOB
{
    class Core
    {
        file = "jobSystem\functions";
        class init       { postInit = 1; };
        // communs (client + serveur)
        class dbg        {};
        class cfgLevel   {};
        class fmtDur     {};
        class pointList  {};
        class pointPos   {};
        class pointDist  {};
        class pointTop   {};
        class gps        {};
        class route      {};
        // client
        class doStep     {};
        class targetLoop {};
        class poleOpen   {};
        class poleBuild  {};
        class pgPhone    {};
        class quizAsk    {};
        class quizBuild  {};
        class clientEject {};
        class clientItem {};
        // serveur
        class nowMin     {};
        class getXp      {};
        class nearPole   {};
        class srvAssign  {};
        class srvSync    {};
        class srvAskSync {};
        class srvAnim    {};
        class clientAnim {};
        class srvOnLoaded {};
        class srvSign    {};
        class srvQuit    {};
        class srvDuty    {};
        class srvStep    {};
        class srvVehSpawn {};
        class srvVehClear {};
    };
};
