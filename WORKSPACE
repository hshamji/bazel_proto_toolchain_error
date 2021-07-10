########################
# Setup
########################

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//tools/build_rules:definitely.bzl", "definitely")

########################
# Versions
########################

bazel_version = "3.7.0"

load("//tools/build_rules:version_check.bzl", "check_bazel_version_at_least")

check_bazel_version_at_least(bazel_version)

skylib_version = "1.0.3"

protobuf_version = "3.15.3"

rules_proto_grpc_version = "3.1.1"


scala_version = "2.12.13"

######################
# Skylib
# -Skylark utilities
######################

definitely(
    http_archive,
    name = "bazel_skylib",
    sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    urls = [
        "https://github.com/bazelbuild/bazel-skylib/releases/download/%s/bazel-skylib-%s.tar.gz" % (skylib_version, skylib_version),
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/%s/bazel-skylib-%s.tar.gz" % (skylib_version, skylib_version),
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

########################
# Protobuf/gRPC Support
# -for Scala and Python
########################

definitely(
    http_archive,
    name = "com_google_protobuf",
    sha256 = "b10bf4e2d1a7586f54e64a5d9e7837e5188fc75ae69e36f215eb01def4f9721b",
    strip_prefix = "protobuf-%s" % protobuf_version,
    url = "https://github.com/protocolbuffers/protobuf/archive/v%s.tar.gz" % protobuf_version,
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

definitely(
    http_archive,
    name = "rules_proto_grpc",
    sha256 = "7954abbb6898830cd10ac9714fbcacf092299fda00ed2baf781172f545120419",
    strip_prefix = "rules_proto_grpc-%s" % rules_proto_grpc_version,
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/%s.tar.gz" % rules_proto_grpc_version],
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")

rules_proto_grpc_toolchains()

rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()


########################
# Scala Support
########################

rules_scala_version = "5df8033f752be64fbe2cedfd1bdbad56e2033b15"
http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "b7fa29db72408a972e6b6685d1bc17465b3108b620cb56d9b1700cf6f70f624a",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    type = "zip",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
)

load("@rules_proto_grpc//scala:repositories.bzl", rules_proto_grpc_scala_repos = "scala_repos")
#
rules_proto_grpc_scala_repos()

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config(scala_version = scala_version)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

#load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

#scala_register_toolchains()



#------------START



load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
#This was hiding generating the same toolchains I wanted. Recreating this manually
#scala_proto_repositories()

load(
    "@io_bazel_rules_scala//scala:scala_cross_version.bzl",
    _default_maven_server_urls = "default_maven_server_urls",
)
load(
    "@io_bazel_rules_scala//scala_proto/private:scala_proto_default_repositories.bzl",
    "scala_proto_default_repositories",
)

maven_servers = _default_maven_server_urls()

#scala_proto_default_repositories(maven_servers)
overriden_artifacts = {}

load("@io_bazel_rules_scala//third_party/repositories:repositories.bzl", "repositories")
repositories(
    for_artifact_ids = [
        "scala_proto_rules_scalapb_plugin",
        "scala_proto_rules_protoc_bridge",
        "scala_proto_rules_scalapb_runtime",
        "scala_proto_rules_scalapb_runtime_grpc",
        "scala_proto_rules_scalapb_lenses",
        "scala_proto_rules_scalapb_fastparse",
        "scala_proto_rules_grpc_core",
        "scala_proto_rules_grpc_api",
        "scala_proto_rules_grpc_stub",
        "scala_proto_rules_grpc_protobuf",
        "scala_proto_rules_grpc_netty",
        "scala_proto_rules_grpc_context",
        "scala_proto_rules_perfmark_api",
        "scala_proto_rules_guava",
        "scala_proto_rules_google_instrumentation",
        "scala_proto_rules_netty_codec",
        "scala_proto_rules_netty_codec_http",
        "scala_proto_rules_netty_codec_socks",
        "scala_proto_rules_netty_codec_http2",
        "scala_proto_rules_netty_handler",
        "scala_proto_rules_netty_buffer",
        "scala_proto_rules_netty_transport",
        "scala_proto_rules_netty_resolver",
        "scala_proto_rules_netty_common",
        "scala_proto_rules_netty_handler_proxy",
        "scala_proto_rules_opencensus_api",
        "scala_proto_rules_opencensus_impl",
        "scala_proto_rules_disruptor",
        "scala_proto_rules_opencensus_impl_core",
        "scala_proto_rules_opencensus_contrib_grpc_metrics",
    ],
    maven_servers = maven_servers,
    fetch_sources = True,
    overriden_artifacts = overriden_artifacts,
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/scalapb_plugin",
    actual = "@scala_proto_rules_scalapb_plugin",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/protoc_bridge",
    actual = "@scala_proto_rules_protoc_bridge",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/scalapb_runtime",
    actual = "@scala_proto_rules_scalapb_runtime",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/scalapb_runtime_grpc",
    actual = "@scala_proto_rules_scalapb_runtime_grpc",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/scalapb_lenses",
    actual = "@scala_proto_rules_scalapb_lenses",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/scalapb_fastparse",
    actual = "@scala_proto_rules_scalapb_fastparse",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/grpc_core",
    actual = "@scala_proto_rules_grpc_core//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/grpc_api",
    actual = "@scala_proto_rules_grpc_api//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/grpc_stub",
    actual = "@scala_proto_rules_grpc_stub//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/grpc_protobuf",
    actual = "@scala_proto_rules_grpc_protobuf//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/grpc_netty",
    actual = "@scala_proto_rules_grpc_netty//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/grpc_context",
    actual = "@scala_proto_rules_grpc_context//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/perfmark_api",
    actual = "@scala_proto_rules_perfmark_api//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/guava",
    actual = "@scala_proto_rules_guava//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/google_instrumentation",
    actual = "@scala_proto_rules_google_instrumentation//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_codec",
    actual = "@scala_proto_rules_netty_codec//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_codec_http",
    actual = "@scala_proto_rules_netty_codec_http//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_codec_socks",
    actual = "@scala_proto_rules_netty_codec_socks//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_codec_http2",
    actual = "@scala_proto_rules_netty_codec_http2//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_handler",
    actual = "@scala_proto_rules_netty_handler//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_buffer",
    actual = "@scala_proto_rules_netty_buffer//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_transport",
    actual = "@scala_proto_rules_netty_transport//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_resolver",
    actual = "@scala_proto_rules_netty_resolver//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_common",
    actual = "@scala_proto_rules_netty_common//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/netty_handler_proxy",
    actual = "@scala_proto_rules_netty_handler_proxy//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/opencensus_api",
    actual = "@scala_proto_rules_opencensus_api//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/opencensus_impl",
    actual = "@scala_proto_rules_opencensus_impl//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/disruptor",
    actual = "@scala_proto_rules_disruptor//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/opencensus_impl_core",
    actual = "@scala_proto_rules_opencensus_impl_core//jar",
)

bind(
    name = "io_bazel_rules_scala/dependency/proto/opencensus_contrib_grpc_metrics",
    actual = "@scala_proto_rules_opencensus_contrib_grpc_metrics//jar",
)

#register_toolchains("@io_bazel_rules_scala//scala_proto:default_deps_toolchain")




load("//tools/build_rules:check_create.bzl", "check_create")
#check_create()




# ------------ END




# setup ScalaTest toolchain and dependencies
load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")

scalatest_repositories()

scalatest_toolchain()

# Unused dependency checker
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_unused_deps_toolchains")

scala_register_unused_deps_toolchains()

# Load third party dependencies
load("//3rdparty:jvm_workspace.bzl", scala_deps = "maven_dependencies")
load("//3rdparty:target_file.bzl", "build_external_workspace")

build_external_workspace(name = "3rdparty_jvm")

scala_deps()

# register custom toolchain
#register_toolchains("//toolchains:scala_proto_deps_toolchain")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
new_git_repository(
    name = "com_thesamet_scalapb",
    commit = "9c322d6f76f7063b5c937a94a15095b3182f1867",
    remote = "https://github.com/scalapb/ScalaPB.git",
    build_file_content = """
proto_library(
    name = "scalapb_runtime_proto",
    srcs = [ "protobuf/scalapb/scalapb.proto" ],
    visibility = [ "//visibility:public" ],
    deps = [ "@com_google_protobuf//:descriptor_proto" ]
)
    """
)
