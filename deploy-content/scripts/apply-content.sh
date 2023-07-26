#!/usr/bin/env bash
set -o errexit # set -e
set -o nounset # set -u

REPOSITORY_PATH=$1

penguinctldocker() {
    docker run --rm -v "$(pwd)":/workdir ghcr.io/vmware-tanzu-learning/penguinctl --url="${PENGUINCTL_APIURL}" --token="${PENGUINCTL_APITOKEN}" "$@"
}

apply_course() {
    file_path=$1
    echo "Applying course at $file_path"
    penguinctldocker apply course -f $file_path
}

apply_guide() {
    file_path=$1
    echo "Applying guide at $file_path"
    penguinctldocker apply guide -f $file_path
}

apply_page() {
    file_path=$1
    echo "Applying page at $file_path"
    penguinctldocker apply page -f $file_path
}

deploy_pages_courses_and_guides() {
    echo "Apply all pages, courses and guides"
    find "${REPOSITORY_PATH}" -name course.json | while read file; do apply_course $file; done
    find "${REPOSITORY_PATH}" -name guide.json | while read file; do apply_guide $file; done
    find "${REPOSITORY_PATH}" -name page.json | while read file; do apply_page $file; done
}

deploy_pages_courses_and_guides