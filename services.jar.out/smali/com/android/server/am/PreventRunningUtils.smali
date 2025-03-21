.class public Lcom/android/server/am/PreventRunningUtils;
.super Ljava/lang/Object;
.source "PreventRunningUtils.java"


# static fields
.field private static ams:Lcom/android/server/am/ActivityManagerService;

.field private static mPreventRunning:Lcom/android/server/am/PreventRunning;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 21
    new-instance v0, Lcom/android/server/am/PreventRunning;

    invoke-direct {v0}, Lcom/android/server/am/PreventRunning;-><init>()V

    sput-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    return-void
.end method

.method public static clearSender()V
    .locals 2

    .prologue
    .line 87
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/android/server/am/PreventRunning;->setSender(Ljava/lang/String;)V

    .line 88
    return-void
.end method

.method private static forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;
    .locals 2

    .prologue
    .line 122
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    .line 123
    invoke-static {p0}, Lcom/android/server/am/ActivityRecord;->forTokenLocked(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v0

    .line 125
    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Lcom/android/server/am/ActivityRecord;->forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v0

    goto :goto_0
.end method

.method private static getAms()Lcom/android/server/am/ActivityManagerService;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->ams:Lcom/android/server/am/ActivityManagerService;

    if-nez v0, :cond_0

    .line 28
    const-string v0, "activity"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    check-cast v0, Lcom/android/server/am/ActivityManagerService;

    sput-object v0, Lcom/android/server/am/PreventRunningUtils;->ams:Lcom/android/server/am/ActivityManagerService;

    .line 30
    :cond_0
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->ams:Lcom/android/server/am/ActivityManagerService;

    return-object v0
.end method

.method public static hookBindService(Landroid/app/IApplicationThread;Landroid/os/IBinder;Landroid/content/Intent;)Z
    .locals 1

    .prologue
    .line 95
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-virtual {v0, p2}, Lcom/android/server/am/PreventRunning;->hookBindService(Landroid/content/Intent;)Z

    move-result v0

    return v0
.end method

.method public static hookStartProcessLocked(Ljava/lang/String;Landroid/content/pm/ApplicationInfo;ZILjava/lang/String;Landroid/content/ComponentName;)Z
    .locals 2

    .prologue
    .line 49
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-static {}, Lcom/android/server/am/PreventRunningUtils;->getAms()Lcom/android/server/am/ActivityManagerService;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/am/ActivityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, p1, p4, p5}, Lcom/android/server/am/PreventRunning;->hookStartProcessLocked(Landroid/content/Context;Landroid/content/pm/ApplicationInfo;Ljava/lang/String;Landroid/content/ComponentName;)Z

    move-result v0

    return v0
.end method

.method public static hookStartService(Landroid/app/IApplicationThread;Landroid/content/Intent;)Z
    .locals 1

    .prologue
    .line 91
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-virtual {v0, p1}, Lcom/android/server/am/PreventRunning;->hookStartService(Landroid/content/Intent;)Z

    move-result v0

    return v0
.end method

.method public static isExcludingStopped(Landroid/content/Intent;)Z
    .locals 3

    .prologue
    .line 34
    invoke-virtual {p0}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 35
    invoke-virtual {p0}, Landroid/content/Intent;->getFlags()I

    move-result v1

    and-int/lit8 v1, v1, 0x30

    const/16 v2, 0x10

    if-ne v1, v2, :cond_0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    .line 36
    invoke-virtual {v1, v0}, Lcom/android/server/am/PreventRunning;->isExcludingStopped(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    .line 35
    :goto_0
    return v0

    .line 36
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static match(Landroid/content/IntentFilter;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Ljava/util/Set;Ljava/lang/String;)I
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/IntentFilter;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Landroid/net/Uri;",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")I"
        }
    .end annotation

    .prologue
    .line 40
    invoke-virtual/range {p0 .. p6}, Landroid/content/IntentFilter;->match(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Ljava/util/Set;Ljava/lang/String;)I

    move-result v1

    .line 41
    if-ltz v1, :cond_0

    .line 42
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/am/PreventRunning;->match(ILjava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Ljava/util/Set;)I

    move-result v1

    .line 44
    :cond_0
    return v1
.end method

.method public static onAppDied(Lcom/android/server/am/ProcessRecord;)V
    .locals 1

    .prologue
    .line 63
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-virtual {v0, p0}, Lcom/android/server/am/PreventRunning;->onAppDied(Ljava/lang/Object;)V

    .line 64
    return-void
.end method

.method public static onBroadcastIntent(Landroid/content/Intent;)V
    .locals 1

    .prologue
    .line 99
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-virtual {v0, p0}, Lcom/android/server/am/PreventRunning;->onBroadcastIntent(Landroid/content/Intent;)V

    .line 100
    return-void
.end method

.method public static onCleanUpRemovedTask(Landroid/content/Intent;)V
    .locals 2

    .prologue
    .line 71
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 72
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-virtual {p0}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/am/PreventRunning;->onCleanUpRemovedTask(Ljava/lang/String;)V

    .line 74
    :cond_0
    return-void
.end method

.method public static onDestroyActivity(Landroid/os/IBinder;)V
    .locals 2

    .prologue
    .line 113
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-static {p0}, Lcom/android/server/am/PreventRunningUtils;->forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/am/PreventRunning;->onDestroyActivity(Ljava/lang/Object;)V

    .line 114
    return-void
.end method

.method public static onLaunchActivity(Landroid/os/IBinder;)V
    .locals 2

    .prologue
    .line 117
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-static {p0}, Lcom/android/server/am/PreventRunningUtils;->forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/am/PreventRunning;->onLaunchActivity(Ljava/lang/Object;)V

    .line 118
    return-void
.end method

.method public static onMoveActivityTaskToBack(Landroid/os/IBinder;)V
    .locals 2

    .prologue
    .line 77
    invoke-static {p0}, Lcom/android/server/am/PreventRunningUtils;->forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v0

    .line 78
    sget-object v1, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    if-eqz v0, :cond_0

    iget-object v0, v0, Lcom/android/server/am/ActivityRecord;->packageName:Ljava/lang/String;

    :goto_0
    invoke-virtual {v1, v0}, Lcom/android/server/am/PreventRunning;->onMoveActivityTaskToBack(Ljava/lang/String;)V

    .line 79
    return-void

    .line 78
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static onResumeActivity(Landroid/os/IBinder;)V
    .locals 2

    .prologue
    .line 109
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-static {p0}, Lcom/android/server/am/PreventRunningUtils;->forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/am/PreventRunning;->onResumeActivity(Ljava/lang/Object;)V

    .line 110
    return-void
.end method

.method public static onStartActivity(ILandroid/app/IApplicationThread;Ljava/lang/String;Landroid/content/Intent;)I
    .locals 2

    .prologue
    .line 53
    if-ltz p0, :cond_1

    if-eqz p3, :cond_1

    const-string v0, "android.intent.category.HOME"

    invoke-virtual {p3, v0}, Landroid/content/Intent;->hasCategory(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "android.intent.category.LAUNCHER"

    invoke-virtual {p3, v0}, Landroid/content/Intent;->hasCategory(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 54
    :cond_0
    invoke-static {}, Lcom/android/server/am/PreventRunningUtils;->getAms()Lcom/android/server/am/ActivityManagerService;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/server/am/ActivityManagerService;->getRecordForAppLocked(Landroid/app/IApplicationThread;)Lcom/android/server/am/ProcessRecord;

    move-result-object v0

    .line 55
    if-eqz v0, :cond_1

    .line 56
    sget-object v1, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    iget-object v0, v0, Lcom/android/server/am/ProcessRecord;->info:Landroid/content/pm/ApplicationInfo;

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/android/server/am/PreventRunning;->onStartHomeActivity(Ljava/lang/String;)V

    .line 59
    :cond_1
    return p0
.end method

.method public static onUserLeavingActivity(Landroid/os/IBinder;ZZ)V
    .locals 2

    .prologue
    .line 103
    if-eqz p2, :cond_0

    .line 104
    sget-object v0, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    invoke-static {p0}, Lcom/android/server/am/PreventRunningUtils;->forToken(Landroid/os/IBinder;)Lcom/android/server/am/ActivityRecord;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/am/PreventRunning;->onUserLeavingActivity(Ljava/lang/Object;)V

    .line 106
    :cond_0
    return-void
.end method

.method public static returnFalse()Z
    .locals 1

    .prologue
    .line 67
    const/4 v0, 0x0

    return v0
.end method

.method public static setSender(Landroid/app/IApplicationThread;)V
    .locals 2

    .prologue
    .line 82
    invoke-static {}, Lcom/android/server/am/PreventRunningUtils;->getAms()Lcom/android/server/am/ActivityManagerService;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/android/server/am/ActivityManagerService;->getRecordForAppLocked(Landroid/app/IApplicationThread;)Lcom/android/server/am/ProcessRecord;

    move-result-object v0

    .line 83
    sget-object v1, Lcom/android/server/am/PreventRunningUtils;->mPreventRunning:Lcom/android/server/am/PreventRunning;

    if-eqz v0, :cond_0

    iget-object v0, v0, Lcom/android/server/am/ProcessRecord;->info:Landroid/content/pm/ApplicationInfo;

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    :goto_0
    invoke-virtual {v1, v0}, Lcom/android/server/am/PreventRunning;->setSender(Ljava/lang/String;)V

    .line 84
    return-void

    .line 83
    :cond_0
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
